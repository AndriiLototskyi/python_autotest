*** Settings ***
Documentation  Login Functionality
Library  SeleniumLibrary
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String

*** Variables ***
${Base_URL}  https://ci-backend-dev-ci-ingress.pres-nonprod.gcphosts.net



*** Test Cases ***
#Verify Successful Login to FornovaMI
#    [documentation]  This test case verifies that user is able to successfully Login to FornovaMI
#    [tags]  Smoke
#    Open Browser  https://ci-dev.fornova.com/  Chrome
#    Wait Until Element Is Visible  css:input[class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']  timeout=6
#    Input Text  css:input[class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']
#    Input Password  css:input[class='form-control icon icon-pass ng-untouched ng-pristine ng-invalid']
#    Click Element  css:button[type='submit']
#    Wait Until Element Is Visible  css:div[class='header__left__logo']  timeout=10
#    Element Should Be Visible  css:div[class='header__left__logo']
#
#Verify Loacation Availability page opening
#	[documentation]  This test case verifies that user is able to successfully enter Location Availability screen
#    [tags]  Smoke
#	Click Element  //span[contains(@class, 'icon-Unavailable-Locations')]
#	Wait Until Element Is Visible  //label[contains(text(),'LOK')]/../div[@class='el-select select el-select--mini']  timeout=5
#    Click Element  //label[contains(text(),'LOK')]/../div[@class='el-select select el-select--mini']
#    Wait Until Element Is Visible  //span[text()='1']  timeout=5
#    Click Element  //span[text()='1']
#    ${numberofNAdaysUI}=  Get Text  //p[contains(text(), 'London Heathrow Airport')]/../..//div[@title='Hertz']/../div[@class='location-data__closed-days']
#    Log To Console  ${numberofNAdaysUI}
#    Close Browser



Get API response
	Create Session  GET_LA_DATA     ${Base_URL}
	${json_response}=    GET On Session  GET_LA_DATA     /car/get-not-available-docs/2023/8/GB/12

    ${data_to_string}=   convert to string    ${json_response.content}
    ${content_without_brackets}=        remove string using regexp    ${data_to_string}   ['\\[\\]']
    ${data_to_json}=    convert string to json    ${content_without_brackets}
#    --> For example, we can take TRUE for Budget from the json <--
    ${data_from_json}=    get value from json    ${data_to_json}  $.pickup_dates.'1'.Budget.'28'
    ${final_data}=  get from list    ${data_from_json}   0

##    log to console  ${json_response.content}
#    ${json_content}=     convert to string    ${json_response.content}
##    log to console    ${json_content}
#    ${content_without_end_bracket}=        remove string using regexp    ${json_content}   ['\\]]
#    ${content_without_start_bracket}=        remove string using regexp    ${content_without_end_bracket}   ['\\[]
##    log to console    ${content}
#    ${pure_json}=    convert string to json     ${content_without_start_bracket}
#
#
#    ${pickup_dates}=    Get Value From Json    ${pure_json}  $.pickup_dates
#    ${pickup_dates_tostring}=  Convert To String    ${pickup_dates}
#    ${pickup_dates_without_end_bracket}=  remove string using regexp    ${pickup_dates_tostring}   ['\\]]
#    ${pickup_dates_without_start_bracket}=  remove string using regexp    ${pickup_dates_without_end_bracket}   ['\\[]
#    ${pickup_dates_replace}=        Replace String Using Regexp  ${pickup_dates_without_start_bracket}  [\b\d]  'hello'
#
##    ${pickup_dates_json}=    convert string to json     ${pickup_dates_regex}
##    ${first_date}=     Get Value From Json    ${pickup_dates}  $.1

    log to console    ${final_data}
#    log to console    ${pickup_dates_regex}
     log to console   "branch_2"
*** Keywords ***