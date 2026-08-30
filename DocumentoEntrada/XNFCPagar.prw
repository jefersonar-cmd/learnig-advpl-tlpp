#Include "protheus.ch"
#Include "topconn.ch"

User Function ZNFCPagar()
    Local cFilial := SF1->F1_FILIAL
    Local cDoc := SF1->F1_DOC
    Local cSerie := SF1->F1_SERIE
    Local cForne := SF1->F1_FORNECE
    Local cLoja := SF1->F1_LOJA
    Local lTemTit := .F.

    If !lTemTit
        MsgStop("Este Documento de Entrada não possui titulos a pagar. Revise-o", "Titulos a Pagar")
        Return
    EndIf
Return
