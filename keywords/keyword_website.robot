*** Settings ***
Documentation   Keywords for website's login test cases
Resource        ../keywords/variables.robot
Library         SeleniumLibrary
Library         String

*** Keywords ***
Navigate to bukalapak's homepage
    open browser            ${URL}        ${BROWSER}
    delete all cookies
    set window size         1440        1120

Navigate to login page
    click element                           link=Login
    wait until element is visible           id=user_session_username
    
Input email
    [Arguments]     ${email}
    wait until element is visible           id=user_session_username
    element attribute value should be       id=user_session_username        placeholder     E-mail / Username / Nomor Handphone
    input text                              id=user_session_username        ${email}

Input username
    wait until element is visible           id=user_session_username
    element attribute value should be       id=user_session_username        placeholder     E-mail / Username / Nomor Handphone
    input text                              id=user_session_username        ${VALID_USERNAME}

Input random username
    ${randomCharacter}=      generate random string      8           [LOWER]
    wait until element is visible           id=user_session_username
    element attribute value should be       id=user_session_username        placeholder     E-mail / Username / Nomor Handphone
    input text                              id=user_session_username        ${randomCharacter}

Input phone number
    wait until element is visible           id=user_session_username
    element attribute value should be       id=user_session_username        placeholder     E-mail / Username / Nomor Handphone
    input text                              id=user_session_username        ${PHONE_NUMBER}

Input random phone number
    ${randomNumber}=        generate random string      12          [NUMBERS]
    wait until element is visible           id=user_session_username
    element attribute value should be       id=user_session_username        placeholder     E-mail / Username / Nomor Handphone
    input text                              id=user_session_username        ${randomNumber} 

Input password
    wait until element is visible           id=user_session_password
    element attribute value should be       id=user_session_password        placeholder     Password
    input text                              id=user_session_password        ${PASSWORD}

Input random password
    ${randomPassword}=      generate random string      6           [NUMBERS]
    wait until element is visible           id=user_session_password
    element attribute value should be       id=user_session_password        placeholder     Password
    input text                              id=user_session_password        ${randomPassword}

Click login button
    wait until element is visible           css=form#new_user_session > button[name='commit']
    click element                           css=form#new_user_session > button[name='commit']

Verify success login
    wait until element is visible           css=.bl-avatar__img             timeout=${TIMEOUT}
    ${currentURL}=          get location
    should be equal as strings              ${currentURL}                   https://www.bukalapak.com/?from=https://www.bukalapak.com/&flash=you_login

Verify error message is appear
    wait until element is visible           css=.o-layout__item.u-4of12.u-push-4of12 > .c-fld__error
    ${errorMessage}=                        get text                css=.o-layout__item.u-4of12.u-push-4of12 > .c-fld__error
    should be equal                         ${errorMessage}         ${WEB_ERROR_MESSAGE}

End website test
    delete all cookies
    close browser