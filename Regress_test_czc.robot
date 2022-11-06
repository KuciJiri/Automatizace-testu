*** Settings ***
Library     Browser



*** Variables ***
${url}      https://www.czc.cz/



*** Test Cases ***
Negative Login
    Wrong Login/Password        KuciJir1             KuciJiri1            KuciJiri             KuciJiri



#Positive Login
#
#
#Add Basket



*** Keywords ***
Cookies
   [Arguments]              ${type}
    IF  "${type}" == "AcceptAll"
        Click               xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
    ELSE
        Click               xpath=//*[@id="ccp-popup"]/div/button
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

