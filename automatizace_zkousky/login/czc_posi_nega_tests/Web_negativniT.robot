*** Settings ***
Library                   Browser


*** Variables ***
${URL}                    https://www.czc.cz/


*** Test Cases ***
Spatne Prihlaseni
    Login_F                 KuciJiri1          KuciJiri1


Pridani do kosiku
    Login_P                KuciJiri          KuciJiri1           Jirka Kucera (KuciJiri)
    ADD                    Apple iPhone 12       513GB           White



Odebrani z kosiku
    Login_P                KuciJiri          KuciJiri1           Jirka Kucera (KuciJiri)
    ADD                    Apple iPhone 12       513GB           White
    Remove                 Pokračovat v objednávce        Odstranit z košíku
    Logout




*** Keywords ***
Cookies
   [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click        xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
    ELSE
        Click        xpath=//*[@id="ccp-popup"]/div/div[2]/button[1]
    END


Login_P
    [Arguments]          ${Ujmeno}           ${heslo}            ${kontrola}
    Log              ${Ujmeno}
    Log              ${heslo}

    New Browser     chromium    headless=false
    New Page                                 ${URL}
    Get Title       ==       CZC.cz - rozumíme vám i elektronice
    Cookies         AcceptAll
    Click           id=login
    Type Text       id=frm-name              ${Ujmeno}
    Type Text       id=frm-password          ${heslo}
    Click           xpath=//*[@id="login-form"]/div[4]/button/span      #Button prihlasit
    Sleep           2
    Take Screenshot
    Get Text        id=logged-user      ==       ${kontrola}

Login_F
    [Arguments]          ${Ujmeno}           ${heslo}
    Log              ${Ujmeno}
    Log              ${heslo}

    New Browser     chromium    headless=false
    New Page                                 ${URL}
    Get Title       ==       CZC.cz - rozumíme vám i elektronice
    Cookies         AcceptAll
    Click           id=login
    Type Text       id=frm-name              ${Ujmeno}
    Type Text       id=frm-password          ${heslo}
    Click           xpath=//*[@id="login-form"]/div[4]/button/span      #Button prihlasit
    Sleep           2
    Take Screenshot
    Get Text        css=.frm__msg-name.frm--invalid          #overeni spatneho hesla
ADD
    [Arguments]     ${nazev}        ${GB}       ${barva}
    ${old_mode} =   Set Strict Mode     false
    Sleep           1
    Click           xpath=//*[@id="fulltext"]   #vyhledavac
    Type text       id=fulltext      mobil
    Sleep           1
    Click           css=.btn.btn-primary.fulltext__btn  #potvrdit button hledat
    Sleep           1
    Click           css=.btn.btn-buy  #vyber mobilu
    Take Screenshot
    Sleep           2
    #Click           xpath=//*[@id="product-price-and-delivery-section"]/div[5]/button[1]  #pridat do kosiku
    Sleep           2
    Click           xpath=//*[@id="basket-preview"]/a       #kosik
    Should Not Contain        ${nazev}        ${GB}       ${barva}     #neobsahuje daný mobil
    Sleep           2

Remove
    [Arguments]      ${btn}     ${krizek}
    Click           css=.icon--ico-filled-delete     #odebrani z kosiku
    Should Not Contain     ${btn}       ${krizek}
    Get Text        css=.op-empty-basket        #overeni prazdeno kosiku
    Go to           ${URL}      #zpet na hlavni stranku


Logout
    Click           id=logged-user
    Click           xpath=//*[@id="blue-menu-wrapper"]/ul[2]/li[2]/div/div[2]/a[1]
