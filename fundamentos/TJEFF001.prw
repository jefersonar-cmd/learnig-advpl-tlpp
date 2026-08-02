#include "Protheus.ch"

/*/{Protheus.doc} TJEFF001
Primeira aula de ADVPL
@type user function
@author Jeff
@since 17/07/2026
@version 12.1.2510
/*/
User Function TJEFF001()
    U_FUN001()
Return

/*
dicas para nomear funções
padronizando função
HMT < EMPRESA
F < Módulo, origem da customização
A < onde dentro do menu entrará? A->Atualizações, C->Consultas, R->Relatórios & M->Miscelânia
001 < Qual projeto

Caso criar um novo prw para o mesmo projeto
retirar primeira letra da empresa e acrescenta uma letra.
De -> HMTFC001
Para -> MTFC001A,MTFC001B...
*/

/*/{Protheus.doc} JEFF001A
    Função Estática, usada para armazenar estudo de variáveis
    @type  Static Function
    @author Jeff Santos
    @since 26/07/2026
    @version 1.12.2510
/*/
Static Function JEFF001A
    // Variável de número
    // variáveis de números reservam "n" <- no ínicio do nome da variável
    Local nMaoEsq := 4
    Local nMaoDir := 3
    Local nResult := nMaoEsq + nMaoDir // somando dados
    Alert(nResult)


    // variáveis de caracter ou texto "c" <- no início do nome da variável
    Local cDescricao := "Caixa de Petiscos"
    Local cProduto := "010203"
    Alert("Produto: "+cProduto+", Descricao: "+cDescricao)

    // variáveis de array tem a letra "a" no início do nome da variáveis
    Local aComoda := {}
    aComoda[1] := "Pedido 1"
    aComada[2] := "Pedido 2"

    // variáveis de matriz tem a letra "a" no início do nome da variáveis
    Local aClientes := {}
    AAdd(aClientes, {"João Leão", 43, "Coordenador de TI", "São Paulo"})
    AAdd(aClientes,{"Maria Antonieta", 22, "Cientista", "Maceió"})
Return
