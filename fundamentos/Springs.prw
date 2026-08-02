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
Return
