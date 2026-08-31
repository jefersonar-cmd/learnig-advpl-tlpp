#Include "protheus.ch"
#Include "topconn.ch"
#Include "fwbrowse.ch"

/*/{Protheus.doc} ZNFCPagar
Botão chamado pela MA103PC.

Valida se o Documento de Entrada corrente possui títulos na SE2.
Se possuir, abre a tela de resumo da NF com os títulos associados.
*/
User Function ZNFCPagar()
    Local cFil     := ""
    Local cDoc     := ""
    Local cSerie   := ""
    Local cForne   := ""
    Local cLoja    := ""
    Local lTemTit  := .F.
    Local cAlias   := GetNextAlias()
    Local cQuery   := ""
    Local aArea    := GetArea()

    cFil   := SF1->F1_FILIAL
    cDoc   := SF1->F1_DOC
    cSerie := SF1->F1_SERIE
    cForne := SF1->F1_FORNECE
    cLoja  := SF1->F1_LOJA

    /*
     * Sua validação original.
     */
    cQuery := " SELECT TOP 1 E2_FILIAL "                         + CRLF
    cQuery += "   FROM " + RetSqlName("SE2") + " SE2 "           + CRLF
    cQuery += "  WHERE SE2.E2_FILIAL  = '" + cFil   + "' "       + CRLF
    cQuery += "    AND SE2.E2_PREFIXO = '" + cSerie + "' "       + CRLF
    cQuery += "    AND SE2.E2_NUM     = '" + cDoc   + "' "       + CRLF
    cQuery += "    AND SE2.E2_FORNECE = '" + cForne + "' "       + CRLF
    cQuery += "    AND SE2.E2_LOJA    = '" + cLoja  + "' "       + CRLF
    cQuery += "    AND SE2.D_E_L_E_T_ = ' ' "

    DbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cAlias, .F., .T.)

    lTemTit := !(cAlias)->(Eof())

    (cAlias)->(DbCloseArea())
    RestArea(aArea)

    If !lTemTit
        MsgStop(;
            "Este Documento de Entrada não possui títulos a pagar." + CRLF + ;
            "Revise o documento selecionado.", ;
            "Títulos a Pagar" ;
        )
        Return
    EndIf

    /*
     * Mantém a sua ZNFCPagar como função principal.
     * Só abre a tela se a validação acima foi aprovada.
     */
    ZNFCTela(cFil, cDoc, cSerie, cForne, cLoja)

Return


/*/{Protheus.doc} ZNFCTela
Renderiza uma tela somente de consulta:

- Resumo do Documento de Entrada
- Fornecedor
- Condição de pagamento
- Total financeiro
- Grid com títulos da SE2
/*/
Static Function ZNFCTela(cFil, cDoc, cSerie, cForne, cLoja)
    Local oDlg        := Nil
    Local oBrowse     := Nil
    Local oBtnFechar  := Nil
    Local oPanelGrid  := Nil 

    Local cAliasTit   := GetNextAlias()
    Local cAliasFor   := GetNextAlias()

    Local cQueryTit   := ""
    Local cQueryFor   := ""

    Local cNomeFor    := ""
    Local cCondPag    := ""
    Local cResumoNF   := ""

    Local nTotal      := 0
    Local nSaldo      := 0

    Local oFontTitulo := TFont():New("Arial",, -14, .T.)
    Local oFontNormal := TFont():New("Arial",, -11, .F.)
    Local oFontBold   := TFont():New("Arial",, -11, .T.)

    Local aArea       := GetArea()

    /*
     * Condição de pagamento da NF.
     *
     * F1_COND pertence à SF1, não à SE2.
     */
    If Select("SF1") > 0
        cCondPag := AllTrim(SF1->F1_COND)
    EndIf

    /*
     * Busca o nome do fornecedor na SA2.
     */
    cQueryFor := " SELECT A2_NOME " + CRLF
    cQueryFor += "   FROM " + RetSqlName("SA2") + " SA2 " + CRLF
    cQueryFor += "  WHERE SA2.A2_FILIAL = '" + ZNFSql(cFil)   + "' " + CRLF
    cQueryFor += "    AND SA2.A2_COD    = '" + ZNFSql(cForne) + "' " + CRLF
    cQueryFor += "    AND SA2.A2_LOJA   = '" + ZNFSql(cLoja)  + "' " + CRLF
    cQueryFor += "    AND SA2.D_E_L_E_T_ = ' ' "

    DbUseArea(.T., "TOPCONN", TcGenQry(,, cQueryFor), cAliasFor, .F., .T.)

    If !(cAliasFor)->(Eof())
        cNomeFor := AllTrim((cAliasFor)->A2_NOME)
    EndIf

    (cAliasFor)->(DbCloseArea())

    /*
     * Query que alimentará a grid.
     */
    cQueryTit := ZNFQueryTitulos(cFil, cDoc, cSerie, cForne, cLoja)

    DbUseArea(.T., "TOPCONN", TcGenQry(,, cQueryTit), cAliasTit, .F., .T.)

    /*
     * Calcula os totais que aparecerão no resumo superior.
     */
    (cAliasTit)->(DbGoTop())

    While !(cAliasTit)->(Eof())

        nTotal += (cAliasTit)->E2_VALOR
        nSaldo += (cAliasTit)->E2_SALDO

        (cAliasTit)->(DbSkip())

    EndDo

    (cAliasTit)->(DbGoTop())

    cResumoNF := "NF: " + AllTrim(cDoc) + ;
                  "   Série: " + AllTrim(cSerie) + ;
                  "   Filial: " + AllTrim(cFil)

    /*
     * Tela renderizada.
     */
    DEFINE MSDIALOG oDlg ;
        TITLE "Resumo Financeiro do Documento de Entrada" ;
        FROM 000, 000 TO 430, 850 ;
        PIXEL ;
        COLORS CLR_BLACK, CLR_WHITE

    /*
     * Título principal.
     */
    @ 010, 010 SAY "Documento de Entrada" ;
        SIZE 250, 014 ;
        OF oDlg ;
        PIXEL ;
        FONT oFontTitulo

    /*
     * Linha 1 do resumo.
     */
    @ 035, 010 SAY "Documento:" SIZE 065, 012 OF oDlg PIXEL FONT oFontBold
    @ 035, 075 SAY AllTrim(cDoc) SIZE 070, 012 OF oDlg PIXEL FONT oFontNormal
    @ 035, 160 SAY "Série:" SIZE 035, 012 OF oDlg PIXEL FONT oFontBold
    @ 035, 195 SAY AllTrim(cSerie) SIZE 050, 012 OF oDlg PIXEL FONT oFontNormal
    @ 035, 270 SAY "Filial:" SIZE 035, 012 OF oDlg PIXEL FONT oFontBold
    @ 035, 310 SAY AllTrim(cFil) SIZE 050, 012 OF oDlg PIXEL FONT oFontNormal

    /*
     * Linha 2: fornecedor.
     */
    @ 055, 010 SAY "Fornecedor:" SIZE 065, 012 OF oDlg PIXEL FONT oFontBold
    @ 055, 075 SAY AllTrim(cForne) + "/" + AllTrim(cLoja) SIZE 075, 012 OF oDlg PIXEL FONT oFontNormal
    @ 055, 160 SAY "Nome:" SIZE 035, 012 OF oDlg PIXEL FONT oFontBold
    @ 055, 195 SAY cNomeFor SIZE 270, 012 OF oDlg PIXEL FONT oFontNormal

    /*
     * Linha 3: condição e valores consolidados.
     */
    @ 075, 010 SAY "Cond. Pagamento:" SIZE 090, 012 OF oDlg PIXEL FONT oFontBold
    @ 075, 105 SAY cCondPag SIZE 050, 012 OF oDlg PIXEL FONT oFontNormal
    @ 075, 180 SAY "Total Títulos:" SIZE 080, 012 OF oDlg PIXEL FONT oFontBold
    @ 075, 265 SAY Transform(nTotal, "@E 999,999,999.99") SIZE 095, 012 OF oDlg PIXEL FONT oFontNormal
    @ 075, 390 SAY "Saldo Aberto:" SIZE 080, 012 OF oDlg PIXEL FONT oFontBold
    @ 075, 475 SAY Transform(nSaldo, "@E 999,999,999.99") SIZE 095, 012 OF oDlg PIXEL FONT oFontNormal

    /*
     * Criação do container (TPanel) via classe para delimitar a Grid.
     */
    oPanelGrid := TPanel():New(105, 010, "", oDlg, , , .T., CLR_BLACK, CLR_WHITE, 405, 125)

    /*
     * Grid com o alias resultante da query SE2.
     */
    oBrowse := FWBrowse():New()
    oBrowse:SetOwner(oPanelGrid)
    oBrowse:SetAlias(cAliasTit)
    oBrowse:SetDataTable(.T.) // IMPORTANTE: Informa que é uma tabela/query temporária
    oBrowse:SetDescription("Títulos Associados")

    /*
     * Colunas da grade (FWBrowse exige Array em vez de Objeto quando SetDataTable = .T.)
     * Formato: { cTitulo, bData, cTipo, cPicture, nAlign, nSize, nDecimal, lOrder }
     */
    oBrowse:AddColumn({"Status",     {|| ZNFStatusTitulo(cAliasTit)}, "C", "", 0, 12, 0, .F.})
    oBrowse:AddColumn({"Prefixo",    {|| (cAliasTit)->E2_PREFIXO},    "C", "", 0, 06, 0, .F.})
    oBrowse:AddColumn({"Título",     {|| (cAliasTit)->E2_NUM},        "C", "", 0, 12, 0, .F.})
    oBrowse:AddColumn({"Parcela",    {|| (cAliasTit)->E2_PARCELA},    "C", "", 0, 06, 0, .F.})
    oBrowse:AddColumn({"Tipo",       {|| (cAliasTit)->E2_TIPO},       "C", "", 0, 05, 0, .F.})
    oBrowse:AddColumn({"Emissão",    {|| (cAliasTit)->E2_EMISSAO},    "D", "", 0, 10, 0, .F.})
    oBrowse:AddColumn({"Vencimento", {|| (cAliasTit)->E2_VENCTO},     "D", "", 0, 10, 0, .F.})
    oBrowse:AddColumn({"Venc. Real", {|| (cAliasTit)->E2_VENCREA},    "D", "", 0, 10, 0, .F.})
    oBrowse:AddColumn({"Valor",      {|| (cAliasTit)->E2_VALOR},      "N", "@E 999,999,999.99", 1, 14, 2, .F.})
    oBrowse:AddColumn({"Saldo",      {|| (cAliasTit)->E2_SALDO},      "N", "@E 999,999,999.99", 1, 14, 2, .F.})
    oBrowse:AddColumn({"Data Baixa", {|| (cAliasTit)->E2_BAIXA},      "D", "", 0, 10, 0, .F.})
    oBrowse:AddColumn({"Natureza",   {|| (cAliasTit)->E2_NATUREZ},    "C", "", 0, 10, 0, .F.})
    oBrowse:AddColumn({"Histórico",  {|| (cAliasTit)->E2_HIST},       "C", "", 0, 50, 0, .F.})

    oBrowse:Activate()

    /*
     * Botão único: tela de consulta.
     */
    @ 245, 335 BUTTON oBtnFechar ; 
        PROMPT "Fechar" ;
        SIZE 070, 018 ;
        OF oDlg ;
        PIXEL ;
        ACTION oDlg:End()

    ACTIVATE MSDIALOG oDlg CENTERED

    /*
     * Fecha a query somente depois que o usuário fechar a tela.
     */
    If Select(cAliasTit) > 0
        (cAliasTit)->(DbCloseArea())
    EndIf

    RestArea(aArea)

Return


/*/{Protheus.doc} ZNFQueryTitulos
Retorna a query dos títulos SE2 associados ao documento selecionado.
/*/
Static Function ZNFQueryTitulos(cFil, cDoc, cSerie, cForne, cLoja)
    Local cQuery := ""

    cQuery := " SELECT " + CRLF
    cQuery += "        SE2.E2_PREFIXO, " + CRLF
    cQuery += "        SE2.E2_NUM, " + CRLF
    cQuery += "        SE2.E2_PARCELA, " + CRLF
    cQuery += "        SE2.E2_TIPO, " + CRLF
    cQuery += "        SE2.E2_EMISSAO, " + CRLF
    cQuery += "        SE2.E2_VENCTO, " + CRLF
    cQuery += "        SE2.E2_VENCREA, " + CRLF
    cQuery += "        SE2.E2_VALOR, " + CRLF
    cQuery += "        SE2.E2_SALDO, " + CRLF
    cQuery += "        SE2.E2_BAIXA, " + CRLF
    cQuery += "        SE2.E2_NATUREZ, " + CRLF
    cQuery += "        SE2.E2_PORTADO, " + CRLF
    cQuery += "        SE2.E2_HIST, " + CRLF
    cQuery += "        SE2.E2_STATUS " + CRLF
    cQuery += "   FROM " + RetSqlName("SE2") + " SE2 " + CRLF
    cQuery += "  WHERE SE2.E2_FILIAL  = '" + ZNFSql(cFil)   + "' " + CRLF
    cQuery += "    AND SE2.E2_PREFIXO = '" + ZNFSql(cSerie) + "' " + CRLF
    cQuery += "    AND SE2.E2_NUM     = '" + ZNFSql(cDoc)   + "' " + CRLF
    cQuery += "    AND SE2.E2_FORNECE = '" + ZNFSql(cForne) + "' " + CRLF
    cQuery += "    AND SE2.E2_LOJA    = '" + ZNFSql(cLoja)  + "' " + CRLF
    cQuery += "    AND SE2.D_E_L_E_T_ = ' ' " + CRLF
    cQuery += "  ORDER BY SE2.E2_PARCELA, SE2.E2_TIPO "

Return cQuery


/*/{Protheus.doc} ZNFStatusTitulo
Monta uma descrição visual para o título.
/*/
Static Function ZNFStatusTitulo(cAlias)
    Local cStatus := AllTrim((cAlias)->E2_STATUS)

    Do Case
    Case cStatus == "A"
        Return "A PAGAR"

    Case cStatus == "B"
        Return "PAGO"

    Case cStatus == "R"
        Return "RELIQUIDADO"

    Case !Empty((cAlias)->E2_BAIXA)
        Return "PAGO"

    Case (cAlias)->E2_SALDO > 0
        Return "A PAGAR"

    Otherwise
        Return "SEM STATUS"
    EndCase

Return ""


/*/{Protheus.doc} ZNFSql
Evita quebra da query caso algum valor tenha apóstrofo.
/*/
Static Function ZNFSql(cValor)
Return StrTran(AllTrim(cValor), "'", "''")
