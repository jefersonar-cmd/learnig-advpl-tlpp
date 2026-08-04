#include "protheus.ch"

/*/{Protheus.doc} Datas
Função para estudo de manipulação de data
@type function
@version  1.12.2510
@author toor
@since 02/08/2026
@return variant, return_description
/*/
User Function Datas()
    Local dDataAtual := Date()
    Local cHora := Time()
    Local cData := ""
    Local nDiasAcres := 0
    Local dDataRes := SToD("")
    Local nResp := 0
    Local cResp := ""

    // converte uma data para texto no formato DD/MM/AAAA
    cData := DToc(dDataAtual)

    // converte um texto no formato "DD/MM/AAAA" para data
    dDataRes := CToD("31/12/2022")

    // converte uma data para texto no formato "AAAAMMDD" - esse é o formato em que as datas são gravadas nas tabelas do protheus
    cData := DToS(dDataAtual)

    // retorna uma data sem considerar final de semana e feriado - funciona apenas executando o protheus
    dDataRes := DataValida(CToD("31/12/2022"), .T.) // próximo a data útil
    dDataRes := DataValida(CToD("31/12/2022"), .F.) // dia útil anterior à data passada no parâmetro

    // retorna o número do dia de uma data
    nRes := Day(dDataAtual)

    // retorna o número do mês de uma data
    nRes := Month(dDataAtual)

    // retorna o número do ano de uma data
    nRes := Year(dDataAtual)

    // retorna o nome do mês de uma data
    cResp := MesExtenso(dDataAtual)

    // retorna uma string de ano e mês no formato AAAAMM
    cResp := AnoMes(dDataAtual)

    // retorna uma string de mes e dia no formato MMDD
    cResp := MesDia(dDataAtual)

    // retorna uma string do dia no formato DD
    cResp := Day2Str(dDataAtual)

    // retorna uma string do mes no formato MM
    cResp := Month2Str(dDataAtual)

    // retorna uma string do ano no formato AAAA
    cResp := Year2Str(dDataAtual)

    // adicionar ou reduzir dias à uma data
    nDiasAcres := 15
    dDataRes := dDataAtual + nDiasAcres
    dDataRes := dDataAtual - nDiasAcres
    dDataRes := DaySum(dDataAtual, nDiasAcres)
    dDataRes := DaySub(dDataAtual, nDiasAcres)

    // adicionar ou reduzir meses de uma data
    dDataRes := MonthSum(dDataAtual, 3)
    dDataRes := MonthSub(dDataAtual, 3)

    // adicionar ou reduzir anos de uma data
    dDataRes := YearSum(dDataAtual, 3)
    dDataRes := YearSub(dDataAtual, 3)

    // diferença de dias, meses ou anos entre duas datas
    nResp := DateDiffDay(CToD("01/02/2023"), Date())
    nResp := DateDiffMonth(CToD("01/06/2023"), Date())
    nResp := DateDiffYear(CToD("01/07/2026"), Date())

    // retorna o número do dia da semana
    nResp := Down(dDataAtual)

    // descrição do dia da semana
    cResp := DiaSemana(dDataAtual)

    // retorna a primeira ou a última data do mês corrente
    dDataRes := FirstDate(dDataAtual)
    dDataRes := LastDate(dDataAtual)

    // retorna o número do último dia do mês
    nResp := Last_Day(dDataAtual)

    // retorna o primeiro ou o último dia do ano de uma data
    dDataRes := FirstYDate(dDataAtual)
    dDataRes := LastYDate(dDateAtual)
Return
