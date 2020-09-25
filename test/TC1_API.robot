*** Settings ***
Documentation   Automation test script for an end-point (GET and POST)
Resource        ../keywords/variables.robot
Library         RequestsLibrary
Library         JSONLibrary
Library         Collections

*** Test Cases ***
a. GET Request
    Create session      GET_Session         ${BASE_URL}         verify=True
    ${response}=        get request         GET_Session        /posts

    ${json_object}=     to json                 ${response.content}
    ${userId_value}=    get value from json     ${json_object}          $..userId
    ${userId_list}=     convert to list         ${userId_value}
    ${id_value}=        get value from json     ${json_object}          $..id
    ${id_list}=         convert to list         ${id_value}
    ${title_value}=     get value from json     ${json_object}          $..title
    ${title_list}=      convert to list         ${title_value}
    ${body_value}=      get value from json     ${json_object}          $..body
    ${body_list}=       convert to list         ${body_value}
    ${length_data}=     get length              ${userId_value}

    #Validations
    ${status_code}=     convert to string       ${response.status_code}
    Should be equal     ${status_code}          200

    FOR     ${data}     IN RANGE        ${length_data}
            ${userId}=   Evaluate        type($userId_list[${data}]).__name__
            ${id}=       Evaluate        type($id_list[${data}]).__name__
            ${title}=    Evaluate        type($title_list[${data}]).__name__
            ${body}=     Evaluate        type($body_list[${data}]).__name__
            Should be equal     ${userId}       int
            Should be equal     ${id}           int
            Should be equal     ${title}        str
            Should be equal     ${body}         str
    END

b. POST Request
    Create session      POST_Session        ${BASE_URL}                 verify=True
    ${body}=            create dictionary   title=recommendation        body=motorcycle     userId=12
    ${header}=          create dictionary   Content-Type=application/json
    ${response}=        post request        POST_Session        /posts          data=${body}        headers=${header}

    #Validations
    ${status_code}=         convert to string       ${response.status_code}
    Should be equal         ${status_code}          201
    
    ${response_body}=       convert to string       ${response.content}
    Should contain          ${response_body}        recommendation
    Should contain          ${response_body}        motorcycle
    Should contain          ${response_body}        12