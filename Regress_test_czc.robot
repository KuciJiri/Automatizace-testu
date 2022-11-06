*** Settings ***
Library     Browser



*** Variables ***
${url}      https://www.czc.cz/



*** Test Cases ***
Negative Login
    Wrong Login/Password         KuciJir1             KuciJiri1            KuciJiri             KuciJiri



Positive Login
    Successful Login             KuciJiri             KuciJiri1          Jirka Kucera (KuciJiri)
    Logout


Add Basket
    Successful Login        KuciJiri             KuciJiri1          Jirka Kucera (KuciJiri)
    Add item                Flash Disky          5
    Logout



*** Keywords ***
Cookies
   [Arguments]              ${type}
    IF  "${type}" == "AcceptAll"
        Click               xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
    ELSE
        Click               xpath=//*[@id="ccp-popup"]/div/button
    END

Timeout
    ${empty} =      Get Text    xpath=//*[@id="basket-visibility-container"]/div/div/h1/strong      #vytahne text/kosik je prazdny
    Log             ${empty}

    FOR     ${i}     IN RANGE    10
            Sleep           200ms
            ${empty} =       Get Text       xpath=//*[@id="basket-visibility-container"]/div/div/h1/strong
            Exit For Loop If      'xpath=//*[@id="basket-visibility-container"]/h1' in '''${empty}'''

            Log    ${empty}
            Log    ${i}
    END

Wrong Login/Password
    [Arguments]             ${Fsurname}           ${password}           ${surname}           ${Fpassword}
    New Browser             chromium             headless=false
    New Page                ${url}
    Get Title       ==      CZC.cz - rozumíme vám i elektronice
    Cookies                 AcceptAll
    Click                   id=login
    Type text               id=frm-name          ${Fsurname}
    Type text               id=frm-password      ${password}
    Click                   xpath=//*[@id="login-form"]/div[4]/button
    Get Text                xpath=//*[@id="login-form"]/div[1]/span[2]      ==      Nesprávné přihlašovací jméno
    Clear Text              id=frm-name
    Type text               id=frm-name          ${surname}
    Type text               id=frm-password      ${Fpassword}
    Click                   xpath=//*[@id="login-form"]/div[4]/button
    Get Text                xpath=//*[@id="login-form"]/div[2]/span[2]      ==      Nesprávné heslo
    Clear Text              id=frm-password
    Click                   xpath=//*[@id="popup-login"]/div/button

Successful Login
    [Arguments]             ${surname}           ${password}         ${check}
    New Browser             chromium             headless=false
    New Page                ${url}
    Get Title       ==      CZC.cz - rozumíme vám i elektronice
    Cookies                 AcceptAll
    Click                   id=login
    Type text               id=frm-name          ${surname}
    Type text               id=frm-password      ${password}
    Click                   xpath=//*[@id="login-form"]/div[4]/button
    Sleep                   1
    Get text                id=logged-user        ==       ${check}
    ${log}=     Get text    id=logged-user
    Log                     ${log}
    Take Screenshot

Logout
    Go to                   ${url}
    Click                   xpath=//*[@id="logged-user"]
    Click                   xpath=//*[@id="blue-menu-wrapper"]/ul[2]/li[2]/div/div[2]/a[1]
    Get text                xpath=//*[@id="login"]     ==     Přihlášení

Add item
    [Arguments]             ${item}        ${piece}
    Click                   xpath=//*[@id="fulltext"]
    Type Text               xpath=//*[@id="fulltext"]           ${item}
    Click                   xpath=//*[@id="wrapper"]/header/div[2]/div/div[1]/form/button
    Sleep                   1
    Click                   xpath=//*[@id="navigation-container"]/div/ul[1]/li[3]/a
    Sleep                   1
    Click                   xpath=//*[@id="tiles"]/div[1]/div[2]/div[2]/button
    Click                   xpath=//*[@id="basket-preview"]/a
    ${amount}               Evaluate            ${piece} - 1
    Click                   css=.up     clickCount=${amount}
    Sleep                   1
    Take Screenshot
    Click                   css=.btn-circle-remove
    Timeout
    #Sleep                   1
    #Get Text                xpath=//*[@id="basket-visibility-container"]/div/div/h1/strong       ==       košík je prázdný



