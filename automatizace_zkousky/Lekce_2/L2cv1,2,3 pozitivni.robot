*** Settings ***
Library   OperatingSystem


*** Variables ***
${ov1}      Volume in drive C
${ov2}      robotframework


*** Test Cases ***
#Pozitivni testy

První pozitivni test
    PrvniT      3   2   1   start

Druhý pozitivni test
    DruhyT


*** Keywords ***
prvniT
    ${result} =        run                   dir C:\
    Log               ${result} ${ov1}
    Should Contain    ${ov1}                 Volume in drive C
    [Arguments]                              ${para1}     ${para2}    ${para3}    ${para4}
    @{seznam} =       Create List            ${para1}     ${para2}    ${para3}    ${para4}
    Log Many          @{seznam}



druhyT
    ${result} =        run                   pip list
    Log               ${result} ${ov2}
    Should Contain    ${ov2}                 robotframework