#include "protheus.ch"

/*/{Protheus.doc} Strings
Estudo sobre stirngs
@type function
@version  1.12.2510
@author toor
@since 02/08/2026
/*/
User Function Strings()
    Local cTexto1 := "" // notação húngara, começar uma variável de texto com a letra 'c'
    Local cTexto2 := "" //sempre inicilizar a variáveis com vazio ""
    Local cResp := ""
    Local cHtml := ""
    Local nAt := 0
    Local nRat := 0
    Local lResp := .T.
    Local nResp := 0
    Local aResp := {}

    //concatenar 2 textos
    cTexto1 := "Estou me tornando"
    cTexto2 := " um analista Protheus!"
    cResp := cTexto1 + cTexto2

    //concatenar textos na mesma variável com quebra de linha
    cResp := "Exemplo de texto na linha 1" + CRLF
    cResp := "Exemplo de texto na linha 2" + CRLF
    cResp := "Exemplo de texto na linha 3" + CRLF
    cResp := "Exemplo de texto na linha 4" + CRLF
    cResp := "Exemplo de texto na linha 5" + CRLF

    // remover espaços à esquerda e à direita do texto
    cTexto1 := "          Texto com Espaços      "
    cResp := LTrim(cTexto1)
    cResp := RTrim(cTexto1)
    cResp := AllTrim(cTexto1)

    // criar uma string de espaços
    cResp := Space(20)

    // exemplo de quando usar aspas simples para definir uma string
    cHtml := '<a href="https://www.freecodecamp.org/" target="_self">freeCodeCamp</a>'

    // converte uma string do padrão ANSI para OEM
    cTexto1 := "Jefferson Araújo"
    cResp := ANSIToOEM(cTexto1)

    // converte um caractere para seu valor mais à esquerda da tabela ASCII
    cResp := Asc("A")
    cResp := Asc("b")
    cResp := Asc(" ")

    // pesquisa a posição de um texto dentro do outro
    cTexto1 := "Jefferson Araújo Dev ADVPL Sênior"
    nAt := AT("ADVPL", cTexto1)
    // pesquisa a última ocorrencia de um texto dentro de outro
    nRat := RAt("o", cTexto1)

    // valida se o caractere é uma letra
    cTexto1 := "A"
    cTexto2 := "1"
    lResp := IsAlpha(cTexto1)
    lResp := IsAlpha(cTexto2)
    // valida se o caractere é número
    lResp := IsDigit(cTexto1)
    lResp := IsDigit(cTexto2)

    // retorna o tamanho da string
    cTexto1 := "Jefferson Araújo Dev ADVPL Sênior"
    nResp := Len(cTexto1)

    // retorna o lado esquedo de uma string da posição informada em diante
    cResp := Left(cTexto1, 9)
    // e a direita
    cResp := Right(cTexto1, 12)

    // deixa o texto com todas as letras minusculas
    cResp := Lower(cTexto1)
    // e maiuscula
    cResp := Upper(cTexto1)

    // centraliza uma string adicionando caracteres à esquerda e à direita
    cTexto1 := "ADVPL"
    cResp := PadC(cTexto1, 30, "-")
    // adiciona caracteres à direita
    cResp := PadR(cTexto1, 30, " ")
    // adiciona caracteres à esquerda
    cResp := PadL(cTexto1, 30, " ")

    // cria uma string com réplicas de um caractere
    cResp := Replicate("Z", 15)

    // cria um array a partir de uma string com um separar padrões
    cTexto1 := "João, Tiago, Pedro, Vanessa, Camila, Andreia, Glauce"
    aResp := StrToArr(cTexto1, ",")
    aResp := Separa(cTexto1, ",")

    // transforma um caractere da string em outro passado por parâmetro
    cTexto1 := "1.592.367,00"
    cResp := StrTran(StrTran(cTexto1, ".", ""), ",", ".")

    // retorna um pedaço da string
    cTexto1 := "Eu tenho uma mente milionaria"
    cResp := SubStr(cTexto1, 4, 15)

    // transforma qualquer valor em uma string com formatação
    cTexto1 := "00000000000000"
    cResp := Transform(cTexto1, "@R 99.999.999/9999-99")
Return
