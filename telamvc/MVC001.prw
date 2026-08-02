#Include "Protheus.ch"
#Include "FwMVCDef.ch"

/*/{Protheus.doc} MVC001
Primeira Aula de MVC
@type user function
@author Jeff
@since 17/07/2026
@version 12.1.2510
/*/
User Function MVC001()
    Local oBrowse := FwMBrowse():New()

    oBrowse:setAlias('SZ0')
    oBrowse:setDescription('Cadastro de Clientes')
    oBrowse:Activate()

    
Return
