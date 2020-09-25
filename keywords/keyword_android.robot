*** Settings ***
Documentation   Keywords for android app's login test cases
Resource        ../keywords/variables.robot
Library         AppiumLibrary
Library         Process
Library         String

*** Variables ***
${APPIUM_PORT}          4723
${APPIUM_HOST}          http://localhost:${APPIUM_PORT}/wd/hub
${DEVICE_NAME}          emulator-5554
${UDID}                 emulator-5554
${APP}                  /Users/ditautamip/Documents/Research Automation/Robotframework/bukalapak/apk/Sample Android App Login Test_v4.0_apkpure.com.apk
${PLATFORM_VERSION}     7
${PLATFORM_NAME}        Android
${BOOTSTRAP_PORT}       4724
${AVD_DEVICES}          Nexus_5X_API_24

*** Keywords ***
Open login register application
	Spawn Appium Server
    Open Application        ${APPIUM_HOST}
    ...     platformName=${PLATFORM_NAME}
    ...     platformVersion=${PLATFORM_VERSION}
    ...     deviceName=${DEVICE_NAME}
    ...     app=${APP}
    ...     udid=${UDID}
    ...     avd=${AVD_DEVICES}
    Set Appium Timeout     ${TIMEOUT}
    Create account

Spawn Appium Server
    Get Working Path
    start process       appium  -p  ${APPIUM_PORT}  -bp  ${BOOTSTRAP_PORT}  stdout=${WORKING_PATH}/appium-log-${PLATFORM_NAME}.txt  shell=true
    sleep   5

Get Working Path
    run process         pwd                 shell=True      alias=proc1
    ${WORKING_PATH}=    get process result  proc1           stdout=true
    set suite variable  ${WORKING_PATH}

Appium stop
    terminate All Processes             kill=True
    sleep   5

Close application
    run keyword and ignore error        close all applications
    appium stop

Input email
    [Arguments]         ${email}
    wait until element is visible           id=com.loginmodule.learning:id/textInputEditTextEmail
    input text                              id=com.loginmodule.learning:id/textInputEditTextEmail       ${email}

Input password
    wait until element is visible           id=com.loginmodule.learning:id/textInputEditTextPassword
    input text                              id=com.loginmodule.learning:id/textInputEditTextPassword    ${PASSWORD}

Input random password
    ${randomPassword}=        generate random string      6          [NUMBERS]
    wait until element is visible           id=com.loginmodule.learning:id/textInputEditTextPassword
    input text                              id=com.loginmodule.learning:id/textInputEditTextPassword    ${randomPassword}

Click login button
    wait until element is visible           id=com.loginmodule.learning:id/appCompatButtonLogin
    click element                           id=com.loginmodule.learning:id/appCompatButtonLogin

Verify error message for invalid email is appear
    wait until page contains                ${APP_ERROR_MESSAGE1}
    ${errorMessage}=        get text        xpath=//android.widget.TextView[contains(@text, '${APP_ERROR_MESSAGE1}')]
    should be equal as strings              ${errorMessage}                 ${APP_ERROR_MESSAGE1}

Verify error message for wrong email or password is appear
    wait until page contains                ${APP_ERROR_MESSAGE2}
    ${errorMessage}=        get text        xpath=//android.widget.TextView[contains(@text, '${APP_ERROR_MESSAGE2}')]
    should be equal as strings              ${errorMessage}                 ${APP_ERROR_MESSAGE2}

Verify success login
    wait until page contains                Android NewLine Learning
    ${getEmail}=            get text        id=com.loginmodule.learning:id/textViewName
    should be equal as strings              ${getEmail}                         ${VALID_EMAIL}

Go back to login page
    ${getLoginStatus}=                      run keyword and return status       element should be visible       id=com.loginmodule.learning:id/appCompatButtonLogin 
    run keyword if                          '${getLoginStatus}' == 'False'      go back
    wait until element is visible           id=com.loginmodule.learning:id/appCompatButtonLogin
    clear text                              id=com.loginmodule.learning:id/textInputEditTextEmail
    clear text                              id=com.loginmodule.learning:id/textInputEditTextPassword

Create account
    click element                           id=com.loginmodule.learning:id/textViewLinkRegister
    wait until element is visible           id=com.loginmodule.learning:id/textInputEditTextName
    input text          id=com.loginmodule.learning:id/textInputEditTextName                    ${VALID_USERNAME}
    input text          id=com.loginmodule.learning:id/textInputEditTextEmail                   ${VALID_EMAIL}
    input text          id=com.loginmodule.learning:id/textInputEditTextPassword                ${PASSWORD}
    input text          id=com.loginmodule.learning:id/textInputEditTextConfirmPassword         ${PASSWORD}
    click element       id=com.loginmodule.learning:id/appCompatButtonRegister
    wait until element is visible                       id=com.loginmodule.learning:id/snackbar_text
    ${getRegisterMessage}=              get text        id=com.loginmodule.learning:id/snackbar_text
    should be equal as strings          ${getRegisterMessage}        Registration Successful
    go back