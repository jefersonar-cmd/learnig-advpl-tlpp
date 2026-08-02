#Include "protheus.ch"

Static nQtdDecim := 3
Static nTamStr := 20


/*/{Protheus.doc} Numeros
Aprendendo tipos de Dados
@type user function
@author Jefferson
@since 26/07/2026
@version 1.12.2510
@example
(examples)
@see (links_or_references)
/*/
User Function Numeros()
    //Nome da variavel - sem acentuacao, nem espaço, até 10º caracter o programa reconhece.
    //Notação Húngara - sempre que declarar variáveis numéricas, inicie o nome da variável com 'n'
    // Ponto flutuante - a separação decimal é feita por ponto e não por vírgula
    // precisao - a precisao de um resultado é garantido para um número de até 15 algarismos, a partir dai, pode haver distorção

    //Local nVlrTtl := 100.20
    Local nNum1 := 0
    Local nNum2 := 0
    Local nNum3 := 0
    Local nNum4 := 0
    Local nRes := 0
    Local nExpoente := 0
    Local cNum := ""
    Local cResposta := ""

    // Operações matemáticas

    // -- SOMA -- //
    nNum1 := 50
    nNum2 := 100
    nRes := nNum1 + nNum2

    // -- Subtração -- //
    nNum1 := 100
    nNum2 := 50
    nRes := nNum1 - nNum2

    // -- Divisão -- //
    nNum1 := 100
    nNum2 := 4
    nRes := nNum1 / nNum2

    // -- Multiplicação -- //
    nNum1 := 8
    nNum2 := 9
    nRes := nNum1 * nNum2

    // -- Resto da Divisão -- //
    nNum1 := 100
    nNum2 := 2
    nRes := nNum1 % nNum2

    // -- Priorização -- //
    nNum1 := 50
    nNum2 := 100
    nNum3 := 3
    nNum4 := 45
    nRes := nNum1 + nNum2 * nNum3 / nNum4
    nRes := ((nNum1 + nNum2) * nNum3) / nNum4 //priorizacao


    // valores iguais
    cResposta := If(nNum1 == nNum2, "Igual", "Diferente")

    // maior
    cResposta := If(nNum1 > nNum2, "Maior", "Igual ou Menor")

    // Menor
    cResposta := If(nNum1 < nNum2, "Maior", "Igual ou Menor")

    // Diferente usar: != ou <>
    cResposta := If(nNum1 != nNum2, "Maior", "Igual ou Menor")

    // valores absolutos Abs()
    nNum1 := -560.45
    nRes := Abs(nNum)

    // valores inteiros
    nNum1 := 685.7665
    nRes := Int(nNum1)

    // maior de dois números
    nNum1 := 685
    nNum2 := 776
    nRes := Max(nNum1, nNum2)

    // menor entre dois números
    nRes := Min(nNum1,nNum2)

    // Delimitador decimais com arredondamento
    nNum1 := 1234.9876
    nRes := Round(nNum1,nQtdDecim)

    // delimita decimais sem arred
    nRes := NoRound(nNum1,nQtdDecim)

    // gerar números randômicos
    nNum1 := 50
    nNum2 := 50000
    nRes := Randomize(nNum1,nNum2)

    // converte texto em números
    cNum := "543.8973"
    nRes := Val(cNum)

    // converte números em texto
    nNum1 := 14
    cResposta := cValToChar(nNum1)

    // converte número em texto adicionando espaços à esquerda
    nNum1 := 1765.99467
    cResposta := Str(nNum1,nTamStr,nQtdDecim)

    // converte número em texto e adiciona zeros a esquerda
    cResposta := StrZero(nNum1,nTamStr,nQtdDecim)

    // Converte número em texto usando máscara
    nNum1 := 13345598.7356
    cResposta := "Um dia eu terei mais de R$" + Transform(nNum1, "@E 999,999,999.99") + "! Eu tenho uma mente milionária!"

    // converte um número para o caractere correspondente na tabela ASCII
    cResposta := Chr(68)+Chr(101)+Chr(105)+Chr(120)+Chr(101)+Chr(32)+;
                Chr(115)+Chr(101)+Chr(117)+Chr(32)+;
                Chr(76)+Chr(73)+Chr(75)+Chr(69)+Chr(33)
    Alert(cResposta)
Return
