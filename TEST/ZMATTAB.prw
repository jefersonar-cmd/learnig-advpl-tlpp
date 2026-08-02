#Include "protheus.ch"
#Include "totvs.ch"

User Function ZMATTAB()
    Local aPergs   := {}
    Local aRet     := {}
    Local cAlias   := ""
    Local cArquivo := ""
    Local lOk      := .F.

    aAdd(aPergs, { 1, "Alias da tabela", Space(3), "@!", "", "", "", 3, .F. })

    If !ParamBox(aPergs, "Materializar tabela customizada", @aRet)
        Return
    EndIf

    cAlias := Upper(AllTrim(aRet[1]))

    If Empty(cAlias)
        MsgAlert("Informe o alias da tabela.", "Atenção")
        Return
    EndIf

    cArquivo := fGetArquivoSX2(cAlias)

    If Empty(cArquivo)
        MsgStop("Tabela não encontrada no SX2: " + cAlias, "Erro")
        Return
    EndIf

    If Left(cAlias, 1) <> "Z" .And. Left(cAlias, 2) <> "SZ"
        If !MsgYesNo("A tabela informada não parece customizada. Deseja continuar?", "Confirmação")
            Return
        EndIf
    EndIf

    lOk := fMaterializaTabela(cAlias, cArquivo)

    If lOk
        MsgInfo("Tabela " + cArquivo + " criada/validada com sucesso.", "Sucesso")
    Else
        MsgStop("Falha ao criar/validar a tabela " + cArquivo + ".", "Erro")
    EndIf

Return

Static Function fGetArquivoSX2(cAlias)
    Local cArquivo := ""
    Local aArea    := FWGetArea()
    Local cChave   := PadR(Upper(AllTrim(cAlias)), 3)

    cArquivo := AllTrim(Posicione("SX2", 1, cChave, "X2_ARQUIVO"))

    FWRestArea(aArea)

Return cArquivo

Static Function fMaterializaTabela(cAlias, cArquivo)
    Local lRet    := .T.
    Local cTmpAli := GetNextAlias()
    Local aArea   := FWGetArea()

    Begin Sequence

        CheckFile(cAlias, cArquivo)

        dbUseArea(.T., "TOPCONN", RetSqlName(cAlias), cTmpAli, .F., .T.)

        If Select(cTmpAli) <= 0
            lRet := .F.
            Break
        EndIf

        (cTmpAli)->(dbGoTop())
        (cTmpAli)->(dbCloseArea())

    Recover
        lRet := .F.
    End Sequence

    FWRestArea(aArea)

Return lRet
