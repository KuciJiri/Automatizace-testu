*** Settings ***
Library     Browser
Library     DebugLibrary



*** Variables ***
${url}      https://www.czc.cz/



*** Test Cases ***

Negative Login
    Wrong Login                  KuciJir1             KuciJiri1
    Wrong Password               KuciJiri             KuciJiri



Positive Login
    Successful Login             KuciJiri             KuciJiri1          Jirka Kucera (KuciJiri)
    Logout


Add and remove items in Basket
    Successful Login             KuciJiri             KuciJiri1          Jirka Kucera (KuciJiri)
    Add item                     Flash Disky          5
    Logout

Create wish list in basket
    Successful Login             KuciJiri             KuciJiri1          Jirka Kucera (KuciJiri)
    Add more item               Grafické Karty          Operační Paměti     Procesory       Zdroje
    Wish List_NewFunction
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
            Sleep            200ms
            ${empty} =       Get Text       xpath=//*[@id="basket-visibility-container"]/div/div/h1/strong
            Exit For Loop If      'xpath=//*[@id="basket-visibility-container"]/h1' in '''${empty}'''

            Log    ${empty}
            Log    ${i}
    END

Wrong Login
    [Arguments]             ${Fsurname}           ${password}
    New Browser             chromium             #headless=false
    New Page                ${url}
    Get Title       ==      CZC.cz - rozumíme vám i elektronice
    Cookies                 AcceptAll
    Click                   id=login
    Type text               id=frm-name          ${Fsurname}
    Type text               id=frm-password      ${password}
    Click                   xpath=//*[@id="login-form"]/div[4]/button
    Get Text                xpath=//*[@id="login-form"]/div[1]/span[2]      ==      Nesprávné přihlašovací jméno
    Click                   xpath=//*[@id="popup-login"]/div/button

Wrong Password
    [Arguments]             ${surname}           ${Fpassword}
    Go to                   ${url}
    Get Title       ==      CZC.cz - rozumíme vám i elektronice
    Click                   id=login
    Type text               id=frm-name          ${surname}
    Type text               id=frm-password      ${Fpassword}
    Click                   xpath=//*[@id="login-form"]/div[4]/button
    Get Text                xpath=//*[@id="login-form"]/div[2]/span[2]      ==      Nesprávné heslo
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

Add more item
    [Arguments]             ${item2}    ${item3}    ${item4}    ${item5}
    ${old_mode} =   Set Strict Mode     false
    Click                   xpath=//*[@id="fulltext"]
    Type Text               xpath=//*[@id="fulltext"]           ${item2}
    Click                   xpath=//*[@id="wrapper"]/header/div[2]/div/div[1]/form/button
    Sleep                   1
    Click                   css=.btn.btn-buy
    Sleep                   1
    Go to                   ${url}
    Click                   xpath=//*[@id="fulltext"]
    Type Text               xpath=//*[@id="fulltext"]           ${item3}
    Click                   xpath=//*[@id="wrapper"]/header/div[2]/div/div[1]/form/button
    Sleep                   1
    Click                   css=.btn.btn-buy
    Sleep                   1
    Go to                   ${url}
    Click                   xpath=//*[@id="fulltext"]
    Type Text               xpath=//*[@id="fulltext"]           ${item4}
    Click                   xpath=//*[@id="wrapper"]/header/div[2]/div/div[1]/form/button
    Sleep                   1
    Click                   css=.btn.btn-buy
    Sleep                   1
    Go to                   ${url}
    Click                   xpath=//*[@id="fulltext"]
    Type Text               xpath=//*[@id="fulltext"]           ${item5}
    Click                   xpath=//*[@id="wrapper"]/header/div[2]/div/div[1]/form/button
    Sleep                   1
    Click                   css=.btn.btn-buy
    Sleep                   1
    Go to                   ${url}

Wish List_NewFunction
    Click                   css=.header-previews__btn.view-basket
    Sleep                   1
    take Screenshot
    Click                   text="Sdílet košík"
    Sleep                   1
    Click                   xpath=//*[@id="basket-visibility-container"]/span/span/a[4]/span
    Click                   xpath=//*[@id="popup-upl"]/div/form/div[3]/button[1]
    ${wishname}=    Set Variable    My pc
    Type Text               xpath=//*[@id="frm-title"]           ${wishname}
    Sleep                   1
    Click                   text="Uložit"
    Sleep                   1
    Click                   text="Zobrazit seznam"
    Click                   xpath=//*[@id="user-info-left-panel"]/ul/li[3]/details/ul/li[2]
    Take Screenshot
    ${name}=     Get text    xpath=//*[@id="content"]/div/div[2]/a[1]/div/div[1]
    Log                     ${name}
    Get text                xpath=//*[@id="content"]/div/div[2]/a[1]/div/div[1]     ==      ${name}
    Take Screenshot
    Click                   xpath=//*[@id="content"]/div/div[2]/a[2]
    Sleep                   1
    Click                   xpath=/html/body/div[4]/div/button[1]
    Sleep                   1
    Should Not Contain      xpath=//*[@id="content"]/div/div[2]/a[1]/div/div[1]     ==     ${name}

















