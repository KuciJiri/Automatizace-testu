#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#uživatel
${USER1_NAME}               KuciJiri
${USER1_PASSWORD}           KuciJiri1
${USER1_SHORT}              Jirka Kucera (KuciJiri)
${USER1_NAMEFAIL}           KuciJiri1
${USER1_PASSWORDFAIL}       KuciJiri11

#zboží
${ZBOZI01_NAME}             mobil
#${ZBOZI01_ID}               1320669
${ZBOZI02_NAME}             Apple iPhone 12
${ZBOZI02_GB}               513GB
${ZBOZI02_COLOR}            White

#Strings
${TEXT_MainTitle}                   CZC.cz - rozumíme vám i elektronice
${TEXT_EmptyCart}                   Vysypat košík
${TEXT_Prihlasit}                   Přihlásit
${TEXT_Verification01}              Pokračovat v objednávce
${TEXT_Verification02}              Odstranit z košíku
${TEXT_Browser}                     chromium

#Error strings
${ERROR_TEXT_FillCorrectEmail}      Zadejte platný email
${ERROR_TEXT_IncorrectEmailOrPwd}   Zadal(a) jste nesprávný e-mail nebo heslo.
${ERROR_TEXT_EmptyCart}             Košík funguje i jako nákupní seznam

#SELEKTORY pro Login
${SEL_HeaderLoginErrorTxt}      xpath=//div[@class='u-mr--8']
${SEL_HeaderLogin}              id=login
${SEL_UserBoxLogoutBtn}         xpath=//*[@id="blue-menu-wrapper"]/ul[2]/li[2]/div/div[2]/a[1]
#${SEL_LoginFormEmail}          id=email
${SEL_LoginFormPwd}             id=frm-password
${SEL_LoginFormName}            id=frm-name
${SEL_BtnSignIn}                xpath=//*[@id="login-form"]/div[4]/button/span
${SEL_VerificationInvldPwd}     css=.frm__msg-name.frm--invalid
${SEL_CloseBtnLogin}            css=.popup-close.close


#SELEKTORY pro Header
${SEL_HeaderLogo}           id=logged-user
${SEL_SearchGlobal}         id=fulltext
${SEL_BtnSearchGlobal}      text=Hledat

#SELEKTORY pro zboží
${SEL_Searching}            xpath=//*[@id="fulltext"]
${SEL_SearchingBtn}         css=.btn.btn-primary.fulltext__btn
${SEL_BtnAdd}               css=.btn.btn-buy
${SEL_ProductID}            data-product-id
${SEL_CssForAdding}         .amountCounterWrap
${SEL_BtnPlus}              css=[class="up"]
${SEL_BtnMinus}             css=[class="down"]

#SELEKTORY pro Košík
${SEL_Cart}                 id=cart
${SEL_CartContent}          xpath=//*[@id="basket-preview"]/a
${SEL_CartReview}           id=cartReviewMainTitle
${SEL_CartRemove}           css=.icon--ico-filled-delete
${SEL_CartVerification}     css=.op-empty-basket

#SELEKTORY pro Cookie
${SEL_Cookie_AllowAll}      xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
${SEL_Cookie_Decline}       xpath=//*[@id="ccp-popup"]/div/div[2]/button[1]