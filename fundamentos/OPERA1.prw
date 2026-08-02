#Include "protheus.ch"

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
    Local aNomes := {"João", "Maria", "Pedro"}

    // Matemática
    nResp := nNum1 + nNum2 // soma
    nResp := nNum1 - nNum3 // subtração
    nResp := nNum1 * nNum2 // multiplicação
    nResp := nNum1 / nNum2 // divisão
    nResp := nNum4 % nNum2 // resto da divisão

    // operação de strings
    cTexto1 := "João" + " Leão"
    cTexto2 := "João,Paulo,Pedro,Tiago"
    lResposta := cTexto1 $ cTexto2 // comparando strings, se string está contida na outra

    // operadores de comparação
    lResposta := nNum1 > nNum2 // maior
    lResposta := nNum1 < nNum2 // menor
    lResposta := nNum1 = nNum2 // igualdade
    lResposta := nNum1 >= nNum2 // maior ou igual
    lResposta := nNum1 <= nNum2 // menor ou igual

    // comparação de string
    lResposta := cTexto1 == cTexto2 // exatamente iguais
    lResposta := cTexto1 = cTexto2 // dá falso
    lResposta := cTexto2 != cTexto1 // falso
    lResposta := cTexto2 <> cTexto1 // falso
    lResposta := !(cTexto2 != cTexto1) // falso

    // operadores de atribuição
    // = simples
    nNum1 = 2
    // := atribuição em linha
    nNum2 := nNum1 := 5
    nNum1 := 5
    nNum2 := 5
    cTexto1 := "João"
    // += atribuição com adição
    nNum1 += nNum2
    // -= atribuição com subtração
    nNum1 -= nNum2
    // *= atribuição com multiplicação
    nNum1 *= nNum2
    // /= atribuição com divisão
    nNum1 /= nNum2

    // operação de incremento
    // ++ incremento pós ou pré-fixado
    nNum1++
    nNum1++
    // -- decremento pós ou pré-fixado
    nNum2--
    nNum2--

    // operadores especiais
    // ()
    // U_TJEFF001()
    nResp := ((nNum1 + nNum2) * nNum3) - nNum4

    // [] elementos matriz
    cResposta := aNomes[2]

    // {} definição de matriz, constante ou bloco de código
    aNomes := {"A", "u", "c"}

    // -> identificador de apelido
    //SA1->A1_COD
    //cAliasTop := "SA1"
    //(cAliasTop)->A1_COD

    //& Macrosubstituição
    cTexto1 := "1+2"
    nResp := &cTexto1

    // @ passagem de parâmetro por referência
    // U_VarEscop(@nNum1)
Return
