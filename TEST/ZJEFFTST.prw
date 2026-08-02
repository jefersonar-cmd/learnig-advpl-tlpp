#Include "Protheus.ch"
#Include "TOTVS.ch"

/*/{Protheus.doc} ZJEFTEST
    Função para testes
    @type  Function
    @author jefferson.araujo
    @since 30/07/2026
    @version 1.12.2510
/*/
User Function ZJEFTEST()
    Local aArea        := FWGetArea()
    Local aMotivos     := {}
    Local cComent      := Space(250)
    Local cMotivoSel   := ""
    Local cCodMotivo   := ""
    Local cDescMotivo  := ""
    Local lOk          := .F.

    RPCSetEnv("99", "01", "admin", "Admin@123", "FAT")

    aMotivos := JEFTEST1()

    If Empty(aMotivos)
        MsgAlert("Não existem motivos cadastrados para exclusão.", "Atenção")
        RPCClearEnv()
        FWRestArea(aArea)
        Return .F.
    EndIf

    lOk := fTelaMotivo(@cMotivoSel, @cComent, aMotivos)

    If ! lOk
        RPCClearEnv()
        FWRestArea(aArea)
        Return .F.
    EndIf

    cMotivoSel := AllTrim(cMotivoSel)
    cComent    := AllTrim(cComent)

    If Empty(cMotivoSel)
        MsgAlert("Selecione um motivo válido.", "Atenção")
        RPCClearEnv()
        FWRestArea(aArea)
        Return .F.
    EndIf

    If At("=", cMotivoSel) <= 0
        MsgAlert("Não foi possível identificar o motivo selecionado.", "Atenção")
        RPCClearEnv()
        FWRestArea(aArea)
        Return .F.
    EndIf

    cCodMotivo  := AllTrim(SubStr(cMotivoSel, 1, At("=", cMotivoSel) - 1))
    cDescMotivo := AllTrim(SubStr(cMotivoSel, At("=", cMotivoSel) + 1))

    If Empty(cCodMotivo)
        MsgAlert("Não foi possível identificar o código do motivo.", "Atenção")
        RPCClearEnv()
        FWRestArea(aArea)
        Return .F.
    EndIf

    If cDescMotivo == "OUTROS"
        If Empty(cComent)
            MsgAlert("Informe o comentário da exclusão.", "Atenção")
            RPCClearEnv()
            FWRestArea(aArea)
            Return .F.
        End
    EndIf

    MsgInfo("Motivo: " + cCodMotivo + CRLF + ;
        "Descrição: " + cDescMotivo + CRLF + ;
        "Comentário: " + cComent, "Confirmação")

    RPCClearEnv()
    FWRestArea(aArea)
Return .T.

Static Function fTelaMotivo(cMotivoSel, cComent, aMotivos)
    Local oDlg
    Local oFontTitulo
    Local oFontTexto
    Local oFontCampo
    Local oBtnOk
    Local oBtnCancel
    Local lConfirma := .F.

    cMotivoSel := IIf(Empty(cMotivoSel) .And. Len(aMotivos) > 0, aMotivos[1], cMotivoSel)
    cComent    := AllTrim(cComent)

    DEFINE FONT oFontTitulo NAME "Segoe UI" SIZE 0,-15 BOLD
    DEFINE FONT oFontTexto  NAME "Segoe UI" SIZE 0,-12
    DEFINE FONT oFontCampo  NAME "Segoe UI" SIZE 0,-13

    DEFINE MSDIALOG oDlg TITLE "Exclusão do Pedido" FROM 000,000 TO 450,1010 PIXEL COLORS 0,16777215

    @ 015, 020 SAY "Informe o motivo do cancelamento" SIZE 260,018 OF oDlg PIXEL FONT oFontTitulo
    @ 033, 020 SAY "Selecione um motivo e descreva o contexto da exclusão." SIZE 320,012 OF oDlg PIXEL FONT oFontTexto

    @ 065, 020 SAY "Motivo" SIZE 060,010 OF oDlg PIXEL FONT oFontTexto
    @ 078, 020 COMBOBOX cMotivoSel ITEMS aMotivos SIZE 470,100 OF oDlg PIXEL FONT oFontCampo

    @ 110, 020 SAY "Comentário" SIZE 070,010 OF oDlg PIXEL FONT oFontTexto
    @ 123, 020 GET cComent MULTILINE SIZE 470,055 OF oDlg PIXEL FONT oFontCampo

    @ 190, 300 BUTTON oBtnOk PROMPT "Confirmar" SIZE 080,018 OF oDlg PIXEL ;
        ACTION (fValidaTela(@cMotivoSel, @cComent, @lConfirma, oDlg))

    @ 190, 390 BUTTON oBtnCancel PROMPT "Cancelar" SIZE 080,018 OF oDlg PIXEL ;
        ACTION (lConfirma := .F., oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED

    oFontTitulo:End()
    oFontTexto:End()
    oFontCampo:End()

Return lConfirma

Static Function fValidaTela(cMotivoSel, cComent, lConfirma, oDlg)
    cMotivoSel := AllTrim(cMotivoSel)
    cComent    := AllTrim(cComent)

    If Empty(cMotivoSel)
        MsgAlert("Selecione um motivo.", "Atenção")
        Return
    EndIf

    If Empty(cComent)
        MsgAlert("Informe o comentário da exclusão.", "Atenção")
        Return
    EndIf

    lConfirma := .T.
    oDlg:End()
Return

Static Function JEFTEST1()
    Local aArea   := FWGetArea()
    Local aCombo  := {}

    DbSelectArea("ZMC")
    ZMC->(dbSetOrder(1))
    ZMC->(dbGoTop())

    While ! ZMC->(Eof())
        If ! ZMC->(Deleted())
            AAdd(aCombo, RTrim(ZMC->ZMC_COD) + " = " + RTrim(ZMC->ZMC_DESC))
        EndIf
        ZMC->(DbSkip())
    EndDo

    FWRestArea(aArea)
Return aCombo
