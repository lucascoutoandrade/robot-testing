*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${url}=     https://automationexercise.com/
${link_sign}=    xpath=//*[@id="header"]/div/div/div/div[2]/div/ul/li[4]/a
${input_name}=    name=name
${input_email}=    css=form > input[type=email]:nth-child(3)
${btn_sign}=    xpath=//button[text()='Signup']
${msg_esperada}=    ACCOUNT CREATED!
${number_random}=     Set Variable    Generate Random String    7    0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVv


*** Keywords ***
abrir site
    Open Browser    ${url}    chrome
    ##Maximize Browser Window
 
efetuar cadastro
    ${number_random}=     Generate Random String    7    0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVv
    Log To Console    name_random: ${number_random}
    Click Link    ${link_sign}
    ${input_name_random}    Set Variable    test_${number_random}
    Set Global Variable    ${input_name_random}
    Input Text    ${input_name}    ${input_name_random}
    Input Text    ${input_email}     ${input_name_random}@test.com.br
    Click Button  ${btn_sign}
    Input Text    password    test
    Input Text    first_name    test
    Input Text    last_name    test
    Input Text    address1    RUA NICOLAU MAEVSKY
    Scroll Element Into View    //*[text()='Create Account']
    Input Text    state    SP
    Input Text    city    JANDIRA
    Input Text    zipcode    06622005
    Input Text    mobile_number    932036205
    Scroll Element Into View    id=susbscribe_email
      Sleep    3s
    Click Button    //*[text()='Create Account']

    
  
validar msg sucesso
    ${msg}=    Get WebElement    css=#form > div > div > div > h2 > b  
    Log To Console    ${msg.text} 
    Should Contain    ${msg.text}    ${msg_esperada}
    Click Link    xpath=//a[text()='Continue']
validar user criado
    ${value_logged_user}=    Get WebElement    css=div > ul > li:nth-child(10) > a
    Log To Console      user_capturado: ${value_logged_user.text}
    Should Contain    ${value_logged_user.text}     ${input_name_random}    

*** Test Cases ***
Cenário 1 - Efetuar Login
    abrir site
    efetuar cadastro
    validar msg sucesso
    validar user criado

