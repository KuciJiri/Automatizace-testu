*** Settings ***
Library  Browser
Resource    Data_and_Config/TestData.robot
Resource    Data_and_Config/Configuration.robot

Test Setup          Pred_testem
Test Teardown       Po_testu_kontrola          Jirka Kucera      (KuciJiri)

Suite Setup         Pred_sadou
Suite Teardown      Po_sade

Test Timeout        ${TC_TIMEOUT_ROBOT_KW}


*** Variables ***
${URL}                 https://www.czc.cz/



*** Test Cases ***
Prihlaseni a odhlaseni
    Login             ${USER1_NAME}              ${USER1_PASSWORD}           ${USER1_SHORT}
    Logout            Jirka Kucera      (KuciJiri)
Pridani do kosiku
    Login             ${USER1_NAME}              ${USER1_PASSWORD}           ${USER1_SHORT}
    ADD2              ${ZBOZI02_NAME}            ${ZBOZI02_GB}               ${ZBOZI02_COLOR}
    Logout            Jirka Kucera      (KuciJiri)
Odebrani z kosiku
    Login             ${USER1_NAME}              ${USER1_PASSWORD}           ${USER1_SHORT}
    ADD2              ${ZBOZI02_NAME}            ${ZBOZI02_GB}               ${ZBOZI02_COLOR}
    Remove            ${TEXT_Verification01}     ${TEXT_Verification02}
    Logout            Jirka Kucera      (KuciJiri)

Spatne Prihlaseni uzivatele
    Login_F           ${USER1_NAMEFAIL}          ${USER1_PASSWORD}           ${USER1_NAME}        ${USER1_PASSWORDFAIL}


*** Keywords ***
Cookies
   [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click        ${SEL_Cookie_AllowAll}
    ELSE
        Click        ${SEL_Cookie_Decline}
    END

#Checkbox
#    [Tags]         check
#    ${check}        Set Variable     Nejsem robot
#    IF  "${check}" == "Nejsem robot"
#        Click        css=.frm__checkbox-icon.icon--ico-checkbox
#    ELSE
#        Click        css=.popup-close.close
#    END


Login
    [Arguments]          ${Ujmeno}           ${heslo}           ${kontrola}
    Log              ${Ujmeno}
    Log              ${heslo}

#    New Browser     ${TEXT_Browser}    headless=false
#    New Page                 ${URL}
    Get Title       ==       ${TEXT_MainTitle}
    Cookies         AcceptAll
    Click           ${SEL_HeaderLogin}
    Type Text       ${SEL_LoginFormName}              ${Ujmeno}
    Type Text       ${SEL_LoginFormPwd}               ${heslo}
    #Checkbox        Nejsem robot
    Click           ${SEL_BtnSignIn}                                        #Button prihlasit
    Sleep           1
    Take Screenshot
    Get Text        ${SEL_HeaderLogo}      ==         ${kontrola}

Login_F
    [Arguments]          ${UjmenoF}           ${hesloP}          ${UjmenoP}         ${hesloF}
    Log              ${UjmenoF}
    Log              ${hesloP}

#    New Browser     chromium    headless=false
#    New Page                 ${URL}
    Get Title       ==       ${TEXT_MainTitle}
    Cookies         AcceptAll
    Click           ${SEL_HeaderLogin}
    Type Text       ${SEL_LoginFormName}              ${UjmenoF}
    Type Text       ${SEL_LoginFormPwd}               ${hesloP}
    Click           ${SEL_BtnSignIn}                                         #Button prihlasit
    Sleep           1
    Take Screenshot
    Get Text        ${SEL_VerificationInvldPwd}                              #overeni spatneho hesla
    Click           ${SEL_CloseBtnLogin}
    Click           ${SEL_HeaderLogin}
    Type Text       ${SEL_LoginFormName}              ${UjmenoP}
    Type Text       ${SEL_LoginFormPwd}               ${hesloF}
    Click           ${SEL_BtnSignIn}                                         #Button prihlasit
    Sleep           1
    Take Screenshot
    Click           ${SEL_CloseBtnLogin}

ADD2
    [Arguments]     ${nazev}        ${GB}       ${barva}
    ${old_mode} =   Set Strict Mode     false
    Sleep           1
    Click           ${SEL_Searching}                                         #vyhledavac
    Type text       ${SEL_SearchGlobal}          ${ZBOZI01_NAME}
    Sleep           1
    Click           ${SEL_SearchingBtn}                                      #potvrdit button hledat
    Sleep           1
    Click           ${SEL_BtnAdd}                                            #vyber mobilu
    Take Screenshot
    Sleep           1
    Click           ${SEL_CartContent}                                       #kosik
    Should Not Contain        ${nazev}        ${GB}       ${barva}           #neobsahuje daný mobil
    Sleep           1

Remove

    [Arguments]      ${btn}     ${krizek}
    Click           ${SEL_CartRemove}                                        #odebrani z kosiku
    Sleep           500ms
    Should Not Contain       ${btn}            ${krizek}
    Get Text        ${SEL_CartVerification}                                  #overeni prazdeno kosiku
    Go to           ${URL}                                                   #zpet na hlavni stranku


Logout
    [Arguments]       ${jmeno}           ${login}
    Go To           ${URL}
    Click           ${SEL_HeaderLogo}
    Click           ${SEL_UserBoxLogoutBtn}
    Should Not Contain       ${jmeno}           ${login}                     #overeni odhlaseni


Pred_testem
    Log             Pred kazdym testem otevre znovu prohlizec
    New Browser     ${TEXT_Browser}            headless=false
    New Page                 ${URL}

Po_testu_kontrola
    Log             Overeni logout po kazdem testu
    [Arguments]              ${jmeno}           ${login}
    Should Not Contain       ${jmeno}           ${login}                     #overeni odhlaseni
    New Page                 ${URL}

Pred_sadou
    ${b_timeput} =             Set Browser Timeout                 ${TIMEOUT_BROWSER}
    Log                        Původní hodnota timeout ${b_timeput}
    Open Browser
    New Page                   ${URL}
    Cookies                    AcceptAll


Po_sade
    Log                        Zavre vsechny prohlizece

    Close Browser              ALL


