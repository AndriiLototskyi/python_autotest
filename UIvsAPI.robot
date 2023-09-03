*** Settings ***
Documentation  Login Functionality
Library  SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String

*** Variables ***
${Base_URL}  https://ci-backend-dev-ci-ingress.pres-nonprod.gcphosts.net

${pos_gb_exists}

*** Test Cases ***
Verify Successful Login to FornovaMI
    [documentation]  This test case verifies that user is able to successfully Login to FornovaMI
    [tags]  Smoke
    Open Browser  https://ci-dev.fornova.com/  Chrome
    Wait Until Element Is Visible  css:input[class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']  timeout=6
    Input Text  css:input[class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']
    Input Password  css:input[class='form-control icon icon-pass ng-untouched ng-pristine ng-invalid']
    Click Element  css:button[type='submit']
    Wait Until Element Is Visible  css:div[class='header__left__logo']  timeout=10
    Element Should Be Visible  css:div[class='header__left__logo']

Verify Loacation Availability page opening
	[documentation]  This test case verifies that user is able to successfully enter Location Availability screen
    [tags]  Smoke
	Click Element  //span[contains(@class, 'icon-Unavailable-Locations')]
	Wait Until Element Is Visible  //label[contains(text(),'POS')]/../div[@class='el-select select el-select--mini']  timeout=5
    Click Element  //label[contains(text(),'POS')]/../div[@class='el-select select el-select--mini']
    Wait Until Element Is Visible  //span[contains(text(), 'GB')]  timeout=5
    Click Element  //span[contains(text(), 'GB')]
    ${pos_gb_exists}=  Get Text    //span[contains(text(), 'GB')]
    Set Global Variable     ${pos_gb_exists}
#    ${numberofNAdaysUI}=  Get Text  //p[contains(text(), 'London Heathrow Airport')]/../..//div[@title='Hertz']/../div[@class='location-data__closed-days']
    Log To Console  ${pos_gb_exists}
    Close Browser


#
Get API response
	Create Session  GET_LA_DATA     ${Base_URL}
	${json_response}=    GET On Session  GET_LA_DATA     /car/get-not-available-docs/2023/8/GB/12
    ${data_to_string}=   convert to string    ${json_response.content}
#     log to console     ${data_to_string}
    ${content_without_brackets}=        remove string using regexp    ${data_to_string}   ['\\[\\]']
#     log to console     ${data_to_string}
    ${data_to_json}=    convert string to json    ${content_without_brackets}

#    --> For example, we can take TRUE for Budget from the json <--

    ${pos_from_json}=    get value from json    ${data_to_json}  $.pos

    ${pos_to_String}=   Convert To String      ${pos_from_json}
    log to console     ${pos_to_String}
    ${pos_gb_exists}=        remove string using regexp    ${pos_gb_exists}   ['\\[\\]\\'']
    ${pos_to_String}=        remove string using regexp    ${pos_gb_exists}   ['\\[\\]\\'']
    log to console     ${pos_gb_exists}
    log to console     ${pos_to_String}
    Should Be Equal     ${pos_to_String}    ${pos_gb_exists}

*** Keywords ***