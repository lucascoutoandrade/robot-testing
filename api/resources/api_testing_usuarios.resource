*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections

*** Keywords ***

Criar sessao na ServerRest
    ${headers}=    Create Dictionary    accept=application/json    Content-Type=application/json  
    Create Session    
    ...    alias=serverRest    
    ...    url=https://serverest.dev    
    ...    headers=${headers}   
    # ...    verify=${False}
    ...    disable_warnings=1
Criar um usuario novo
    ${valueRandom}=    Generate Random String    10    0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVv
    ${valueRandom}=    Convert To Lower Case     ${valueRandom}
    Set Test Variable    ${EMAIL_TESTE}    ${valueRandom}@test.com.br
    Log To Console    email: ${EMAIL_TESTE} 

Cadastrar o usuario criado na ServerRest
    [Arguments]    ${email}    ${status_code_esperado}
    ${body}=    Create Dictionary    
    ...    nome=Test Couto    
    ...    email=${EMAIL_TESTE}    
    ...    password=1234    
    ...    administrador=true
    Log To Console    ${body}  

    Criar sessao na ServerRest
    ${response}=    POST On Session    
                ...    alias=serverRest    
                ...    url=/usuarios
                ...    json=${body}
                ...    expected_status=${status_code_esperado}   
    # Log To Console    ${response.json()}

        IF    ${response.status_code} != 400
            Set Test Variable    ${ID_USER}    ${response.json()["_id"]}
            Log To Console    ${ID_USER}     
        END

    Set Test Variable    ${RESPONSE}    ${response.json()}    

Conferir se usuario foi cadastrado com sucesso
    Log To Console    ${RESPONSE}
    Dictionary Should Contain Item         ${RESPONSE}     message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPONSE}    _id
    
Repetir cadastro do usuario
    Cadastrar o usuario criado na ServerRest    email=${EMAIL_TESTE}    status_code_esperado=400 

Verificar se api não permite cadastro duplicado
    Dictionary Should Contain Item    ${RESPONSE}    message    Este email já está sendo usado

Consultar os dados do novo usuário
    ${response}=    GET On Session    
    ...    alias=serverRest    
    ...    url=/usuarios/${ID_USER}

    Set Test Variable    ${RESP_RETORNO_DADOS_USER}    ${response.json()}    
    Log To Console    ${response.json()}
    Set Test Variable    ${EMAIL_CAPTURADO}    ${response.json()["email"]} 
    Log To Console    emailCapturado: ${EMAIL_CAPTURADO}   
    
Conferir os dados retornados
    Dictionary Should Contain Item    ${RESP_RETORNO_DADOS_USER}     email    ${EMAIL_TESTE}
