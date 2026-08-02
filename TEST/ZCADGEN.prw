#Include "protheus.ch"
#Include "parmtype.ch"
#Include "fwmvcdef.ch"

/*/{Protheus.doc} ZCADGEN
Cadastro genérico MVC por alias informado no ParamBox.
Permite abrir browse e formulário usando a tabela digitada pelo usuário.
@type  Function
@author Jefferson
@since 31/07/2026
/*/

Static __cAliasMVC := ""
Static __cTituloMVC := "Cadastro Genérico"
//Static __cRotinaMVC := "ZCADGEN"

User Function ZCADGEN()
    Local aPergs   := {}
    Local aRetPar  := {}
    Local cAlias   := ""
    Local cTitulo  := ""
    Local oBrowse

    aAdd(aPergs, {1, "Tabela/alias:", Space(3),  "", ".T.", "", ".T.", 3, .T.})
    aAdd(aPergs, {1, "Título:",       Space(40), "", ".T.", "", ".T.", 40, .T.})

    If ! ParamBox(aPergs, "Cadastro Genérico", @aRetPar,,,,,,,,.T.,.T.)
        Return
    EndIf

    cAlias  := AllTrim(Upper(aRetPar[1]))
    cTitulo := AllTrim(aRetPar[2])

    If Empty(cAlias)
        MsgStop("Informe uma tabela válida.", "Atenção")
        Return
    EndIf

    If ! TCCanOpen(cAlias)
        MsgStop("Tabela " + cAlias + " não encontrada no dicionário SX2. 1", "Atenção")
        Return
    EndIf

    If Empty(cTitulo)
        cTitulo := "Cadastro Genérico - " + cAlias
    EndIf

    __cAliasMVC  := cAlias
    __cTituloMVC := cTitulo

    // dbSelectArea("SX2")
    // SX2->(dbSetOrder(1))
    // If ! SX2->(dbSeek(xFilial("SX2") + cAlias))
    //     MsgStop("Tabela " + cAlias + " não localizada na SX2. 2", "Atenção")
    //     Return
    // EndIf

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(__cAliasMVC)
    oBrowse:SetDescription(__cTituloMVC)
    oBrowse:SetMenuDef("ZCADGEN")
    oBrowse:DisableDetails()
    oBrowse:Activate()

Return

// Static Function MenuDef()
//     Local aRotina := {}

//     aAdd(aRotina, {"Visualizar" , "VIEWDEF.ZCADGEN", 2, 0, NIL})
//     aAdd(aRotina, {"Incluir"    , "VIEWDEF.ZCADGEN", 3, 0, NIL})
//     aAdd(aRotina, {"Alterar"    , "VIEWDEF.ZCADGEN", 4, 0, NIL})
//     aAdd(aRotina, {"Excluir"    , "VIEWDEF.ZCADGEN", 5, 0, NIL})

// Return aRotina

Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.ZCADGEN" OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.ZCADGEN" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.ZCADGEN" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.ZCADGEN" OPERATION 5 ACCESS 0

Return aRotina

Static Function ModelDef()
    Local oModel
    Local oStru
    Local cAlias := __cAliasMVC
    Local aPk    := {}

    If Empty(cAlias)
        MsgStop("Alias do cadastro genérico não foi inicializado.", "Erro ModelDef")
        Return NIL
    EndIf

    oStru := FWFormStruct(1, cAlias)

    If oStru == NIL
        MsgStop("Não foi possível montar a estrutura do Model para a tabela " + cAlias + ".", "Erro ModelDef")
        Return NIL
    EndIf

    oModel := MPFormModel():New("ZCADGENM")
    oModel:AddFields("MASTER", NIL, oStru)
    oModel:SetDescription(__cTituloMVC)

    aPk := __GetPrimaryKey(cAlias)
    If Len(aPk) > 0
        oModel:SetPrimaryKey(aPk)
    EndIf

Return oModel

Static Function ViewDef()
    Local oModel
    Local oView
    Local oStru
    Local cAlias := __cAliasMVC

    If Empty(cAlias)
        MsgStop("Alias do cadastro genérico não foi inicializado.", "Erro ViewDef")
        Return NIL
    EndIf

    oModel := FWLoadModel("ZCADGEN")

    If oModel == NIL
        MsgStop("Não foi possível carregar o model do cadastro genérico.", "Erro ViewDef")
        Return NIL
    EndIf

    oStru := FWFormStruct(2, cAlias)

    If oStru == NIL
        MsgStop("Não foi possível montar a estrutura da View para a tabela " + cAlias + ".", "Erro ViewDef")
        Return NIL
    EndIf

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_MASTER", oStru, "MASTER")
    oView:CreateHorizontalBox("BOX_MASTER", 100)
    oView:SetOwnerView("VIEW_MASTER", "BOX_MASTER")
    oView:SetCloseOnOk({|| .T.})

Return oView

Static Function __GetPrimaryKey(cAlias)
    Local aPk := {}
    Local cChave := ""

    dbSelectArea("SX2")
    SX2->(dbSetOrder(1))

    If SX2->(dbSeek(xFilial("SX2") + cAlias))
        cChave := AllTrim(SX2->X2_UNICO)

        If ! Empty(cChave)
            aPk := __SplitSX2Key(cChave)
        EndIf
    EndIf

Return aPk

Static Function __SplitSX2Key(cChave)
    Local aRet    := {}
    Local nTam    := 0
    Local nPos    := 1
    Local cCampo  := ""

    cChave := AllTrim(cChave)

    If Empty(cChave)
        Return aRet
    EndIf

    nTam := Len(cChave)

    While nPos <= nTam
        cCampo := SubStr(cChave, nPos, 10)
        cCampo := AllTrim(cCampo)

        If ! Empty(cCampo)
            aAdd(aRet, cCampo)
        EndIf

        nPos += 10
    EndDo

Return aRet
