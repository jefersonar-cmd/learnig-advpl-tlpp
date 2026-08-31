#Include "protheus.ch"
 
/*------------------------------------------------------------------------------------------------------*
 | P.E.:  MA103OPC                                                                                      |
 | Desc:  Inclusão de Ações Relacionadas no Documento de Entrada                                        |
 | Links: http://tdn.totvs.com/pages/releaseview.action?pageId=6085341                                  |
 *------------------------------------------------------------------------------------------------------*/
 
User Function MA103OPC()
    Local aRet := {}
     
    aAdd(aRet,{'Situação Títulos', 'U_ZNFCPAGAR', 0, 5})
Return aRet
