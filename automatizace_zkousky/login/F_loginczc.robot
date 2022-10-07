*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.czc.cz/


*** Test Cases ***
Spatny login prvni pokus
    Login           patrik          12345



Spatny login druhy pokus
    Login           patrikk         54321



Pridani do kosiku
    New Browser          chromium    headless=false
    New Page             ${URL}
    Get Title       ==       CZC.cz - rozumíme vám i elektronice
    Click           xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]  #cookies
    Click           xpath=//*[@id="fulltext"]   #vyhledavac
    Type text       id=fulltext        Mobil
    Sleep       1
    Click           text=Hledat    #potvrdit button hledat
    Click       text="Honor X7, 4GB/128GB, Black"
    Sleep       1
    Click       xpath=//*[@id="product-price-and-delivery-section"]/div[5]/button[1]
    Click       xpath=//*[@id="basket-preview"]/a    #kosik
    Sleep       1
    Click       css=[title="Odstranit z košíku"]
    Sleep       1

#Odebrani z kosiku

*** Keywords ***
Login
    [Arguments]         ${Ujmeno}        ${heslo}


    Log          ${Ujmeno}
    Log          ${heslo}

    New Browser          chromium    headless=false
    New Page             ${URL}
    Get Title       ==       CZC.cz - rozumíme vám i elektronice
    Click           xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]  #cookies
    Click           id=login
    Type Text       id=frm-name              ${Ujmeno}
    Type Text       id=frm-password          ${heslo}
    Click           xpath=//*[@id="login-form"]/div[4]/button/span      #Button prihlasit
    Sleep           1
    Take Screenshot
    Click           xpath=//*[@id="login-form"]/div[2]/a  #klik na zapomeli jste heslo?
    Sleep           1
    Click           xpath=//*[@id="lost-password-popup"]/div/form/div[2]/button  #Button Odeslat
    Sleep           1
    Click           xpath=//*[@id="lost-password-popup"]/div/button  #krizek
    Click           xpath=//*[@id="popup-login"]/div/button   #krizek




