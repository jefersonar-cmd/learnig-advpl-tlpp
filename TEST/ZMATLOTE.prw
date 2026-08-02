User Function ZMATLOTE()
    Local aArea    := FWGetArea()
    Local aLog     := {}
    Local cAlias   := ""
    Local cArquivo := ""

    dbSelectArea("SX2")
    SX2->(dbSetOrder(1))
    SX2->(dbGoTop())

    While !SX2->(Eof())
        cAlias   := AllTrim(SX2->X2_CHAVE)
        cArquivo := AllTrim(SX2->X2_ARQUIVO)

        If Left(cAlias,1) == "Z" .Or. Left(cAlias,2) == "SZ"
            If fMaterializaTabela(cAlias, cArquivo)
                aAdd(aLog, cAlias + " - OK")
            Else
                aAdd(aLog, cAlias + " - ERRO")
            EndIf
        EndIf

        SX2->(dbSkip())
    EndDo

    FWRestArea(aArea)

    MemoWrite("\system\ZMATLOTE.LOG", "")
    AEval(aLog, {|cLinha| MemoWrit("\system\ZMATLOTE.LOG", cLinha + CRLF, .T.)})

    MsgInfo("Processamento concluído.", "Lote")
Return
