#Include "Protheus.ch"

User Function Opera1()
    Local nNum1 := 10
    Local nNum2 := 2
    Local nNum3 := 5
    Local nNum4 := 7
    Local nResp := 0
    Local cTexto1 := ""
    Local cTexto2 := ""
    Local cResposta := ""
    Local cAliasTop := ""
    Local lResposta := .T.
    Local aNomes := {"JoÃ£o", "Maria", "Pedro"}

    // Matemática
    nResp := nNum1 + nNum2 // soma
    nResp := nNum1 - nNum3 // subtração
    nResp := nNum1 * nNum2 // multiplicação
    nResp := nNum1 / nNum2 // divisão
    nResp := nNum4 % nNum2 // resto da divisão

    
Return
