*** Settings ***
Library   OperatingSystem

*** Variables ***
${ov1}       'verr' is not recognized as an internal or external command,
${ov2}       Try "ip /?".


*** Test Cases ***
#Negativní testy

První negativni test
    PrvniT       3   2   1   start



Druhý negativni test
    DruhyT

*** Keywords ***

prvniT
    ${result} =        run                    verr
    Log                ${result} ${ov1}
    Should Contain     ${ov1}                 'verr' is not recognized as an internal or external command,
    [Arguments]                               ${para1}     ${para2}    ${para3}    ${para4}
    @{seznam} =        Create List            ${para1}     ${para2}    ${para3}    ${para4}
    Log Many           @{seznam}

druhyT
    ${result} =        run                    help ip
    Log                ${result} ${ov2}
    Should Contain     ${ov2}                 Try "ip /?".