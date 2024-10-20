*** Settings ***
Resource    ../resources/api_testing_usuarios.resource

*** Variables ***


*** Test Cases ***
Cenario 01: Cadastrar novo usuário com sucesso na ServerRest
    Criar um usuario novo
    Cadastrar o usuario criado na ServerRest    email=${EMAIL_TESTE}    status_code_esperado=201
    Conferir se usuario foi cadastrado com sucesso

Cenario 02: Cadastrar um usuário já existente
    Criar um usuario novo
    Cadastrar o usuario criado na ServerRest    email=${EMAIL_TESTE}    status_code_esperado=201
    Repetir cadastro do usuario
    Verificar se api não permite cadastro duplicado

Cenario:03: Consultar os dados de um novo usuario
     Criar um usuario novo
     Cadastrar o usuario criado na ServerRest    email=${EMAIL_TESTE}    status_code_esperado=201
     Consultar os dados do novo usuário
     Conferir os dados retornados