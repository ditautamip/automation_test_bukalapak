*** Settings ***
Documentation   Automation test script for Bukalapak's website - Login test cases
Resource        ../keywords/keyword_website.robot
Test Setup     Navigate to bukalapak's homepage
Test Teardown  End website test

*** Test Cases ***
01. Verify login with valid username
    Navigate to login page
    ${username}    Input email     ${VALID_USERNAME}
    Input password
    Click login button
    Verify success login

02. Verify login with valid email or phone number
    Navigate to login page
    ${email}    Input email     ${VALID_EMAIL}
    Input password
    Click login button
    Verify success login

03. Verify login with blank email / username / phone number
    Navigate to login page
    Input password
    Click login button
    Verify error message is appear

04. Verify login with blank password
    Navigate to login page
    ${email}    Input email     ${VALID_EMAIL}
    Click login button
    Verify error message is appear

05. Verify login with blank email /username / phone number and password
    Navigate to login page
    Click login button
    Verify error message is appear

06. Verify login with invalid email's format
    Navigate to login page
    ${email}    Input email     ${INVALID_EMAIL}
    Click login button
    Verify error message is appear

07. Verify login with random username
    Navigate to login page
    Input random username
    Click login button
    Verify error message is appear

08. Verify login with random phone number
    Navigate to login page
    Input random phone number
    Click login button
    Verify error message is appear

09. Verfiy login with incorrect email or password
    Navigate to login page
    ${email}    Input email     ${VALID_EMAIL}
    Input random password
    Click login button
    Verify error message is appear

10. Verify login with incorrect username or password
    Navigate to login page
    Input username
    Input random password
    Click login button
    Verify error message is appear

11. Verify login with incorrect phone number or password
    Navigate to login page
    Input phone number
    Input random password
    Click login button
    Verify error message is appear