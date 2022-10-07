*** Settings ***
Library  Browser


*** Variables ***
${URL}                 https://www.czc.cz/


*** Test Cases ***
Prihlaseni a odhlaseni
    Login             KuciJiri          KuciJiri1           Jirka Kucera (KuciJiri)
    Logout            Jirka Kucera      (KuciJiri)

Pridani do kosiku
    Login             KuciJiri          KuciJiri1           Jirka Kucera (KuciJiri)
    ADD



Odebrani z kosiku
    Login             KuciJiri          KuciJiri1           Jirka Kucera (KuciJiri)
    ADD
    Remove
    Logout           Jirka Kucera      (KuciJiri)




*** Keywords ***
Cookies
   [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click        xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
    ELSE
        Click        xpath=//*[@id="ccp-popup"]/div/div[2]/button[1]
    END


Login
    [Arguments]          ${Ujmeno}           ${heslo}           ${kontrola}
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

ADD

    Sleep           1
    Click           xpath=//*[@id="fulltext"]   #vyhledavac
    Type text       id=fulltext        Mobil
    Sleep           1
    Click           css=.btn.btn-primary.fulltext__btn  #potvrdit button hledat
    Sleep           1
    Click           css=[title="Apple iPhone 13 mini, 512GB, Blue Connex TravelCard Unlimited, platnost 1 rok"]  #vyber konkretniho mobilu
    Take Screenshot
    Sleep           2
    Click           xpath=//*[@id="product-price-and-delivery-section"]/div[5]/button[1]  #pridat do kosiku
    Sleep           2
    Click           xpath=//*[@id="basket-preview"]/a       #kosik
    Click           css=[class="up"]
    Sleep           2

Remove

    Click           css=.icon--ico-filled-delete     #odebrani z kosiku
    Get Text        css=.op-empty-basket        #overeni prazdeno kosiku
    Go to           ${URL}      #zpet na hlavni stranku


Logout
    [Arguments]       ${jmeno}           ${login}
    Click           id=logged-user
    Click           xpath=//*[@id="blue-menu-wrapper"]/ul[2]/li[2]/div/div[2]/a[1]
    Should Not Contain       ${jmeno}           ${login}    #overeni odhlaseni

