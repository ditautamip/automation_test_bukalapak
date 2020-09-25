*** Settings ***
Documentation   Automation test script for android app - Login test cases
Resource        ../keywords/keyword_android.robot
Suite Setup     Open login register application
Test Setup      Go back to login page
Suite Teardown  Close application

*** Test Cases ***
01. Verify login with valid email
    ${email}     keyword_android.Input email        ${VALID_EMAIL}
    keyword_android.Input password
    keyword_android.Click login button
    keyword_android.Verify success login

02. Verify login with blank email
    keyword_android.Input password
    keyword_android.Click login button
    Verify error message for invalid email is appear

03. Verify login with blank password
    ${email}    keyword_android.Input email         ${VALID_EMAIL}
    keyword_android.Click login button
    Verify error message for invalid email is appear

04. Verify login with blank email and password
    keyword_android.Click login button
    Verify error message for invalid email is appear

05. Verify login with invalid email's format
    ${email}    keyword_android.Input email         ${INVALID_EMAIL}
    keyword_android.Input password
    keyword_android.Click login button
    Verify error message for invalid email is appear

06. Verify login with incorrect email or password
    ${email}    keyword_android.Input email         ${VALID_EMAIL}
    keyword_android.Input random password
    keyword_android.Click login button
    Verify error message for wrong email or password is appear