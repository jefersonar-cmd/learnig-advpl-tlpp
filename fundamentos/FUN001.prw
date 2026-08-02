#Include "protheus.ch"



/*
    Local:
    Apenas na função/bloco onde foi declarada
    Destruida quando a função termina
    Recomendada sempre que possível (padrão ideal de codigo)

    Private:
    Visivel na função de origem e em todas as subfuncoes chamadas por ela
    destuida quando a função que a criou termina
    Usada quando você precisa repassar dados para recomendada: Pontos de Entrada ou funções filhas sem passar parametros

    Public:
    visivel Em todo sistema (na mesma thread/sessao) após a criação
    destruida quando a sessao do usuário/thread termina
    recomendada: evitar ao máximo (pode causar conflito entre rotinas)

    Referencias
    Local nValor := 0
    U_FUNCCALC(@nValor)

    o que for inserido na nValor interna da função invocada, será atribuida o que declarar

    Local cNome := "Protheus" <- também aceita ''

    Local nValor := 150.50 <- aceita valores inteiros ou com ponto flutuante

    Local dHoje := Date() <- Representa data formatada YYYYMMDD internamente
    Local dCerta := STOD("20260726")

    Local lAtivo := .T. ou .F. <- tipo lógico

    Local aItems := {"Item1", 100, .T.} <- tipo array lista
    Local aItems2 := {}
    aItems2 := aAdd(aItems2, {"Item2", 120, .T.}) <- Matriz

    Local bAcao := {|| Alert("Acao executada!")} <- bloco de ação que pode ser executada com a função nativa Eval(bAcao)

    Local oObjeto1 := FWFormStruct() <- usados para instanciar objetos

    Local uNulo := NIL <- representa ausência de tipo/valor ou variável não iniciada
*/

/*/{Protheus.doc} FUN001
Primeira função
@type user function
@author Jeff
@since 17/07/2026
@version 12.1.2510
/*/
User Function FUN001()
	Local nNumber := 12
	Alert(nNumber)
	EX001(nNumber)
Return

/*/{Protheus.doc} EX001
Primeira função estática
@type user function
@author Jeff
@since 19/07/2026
@version 12.1.2510
/*/
Static Function EX001(nNumEnv)
	Local nNumero := 5
	Default nNumEnv := 0
	if nNumEnv > nNumero
		Alert("É maior")
	else
		Alert("É igual ou menor")
	EndIf
Return

/*/{Protheus.doc} EX001A
Segunda função estática
@type user function
@author Jeff
@since 19/07/2026
@version 12.1.2510
/*/
Static Function EX001A()
	Local nNumber2 := 25
Return nNumber2
/*
se uma static function estiver sendo repetida em vários projetos dentro do RPO, transforme-a em uma User Function para reutilização.
*/


