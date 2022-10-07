*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***
Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT

*** Keywords ***
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    Log             ${pemail}
    Log             ${pheslo}
    Log             ${pnastane}

    New Browser     chromium    headless=false
    New Context
    New Page        ${URL}
    Get Title       ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll    #odklik cookies
    Click           id=headerLogin
    Type Text       id=email                                ${pemail}
    Type Text       xpath=//*[@id="password"]               ${pheslo}
    Sleep           1
    Click           data-test=btnSignIn
    Take Screenshot
    Sleep           1
    Get Text        data-test=header-user-icon      ==      ${pnastane}

    #otevřít prohlížeč

    #otevřít stránku rohlik.cz

    #ověřit že se stránka otevřela

    #kliknout na Přihlásit

    #zadat email ${pemail} do místa pro zadání emailu

    #zadat heslo ${pheslo} do místa pro zadání hesla

    #klinout na tlačítko "Přihlasit se"

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}