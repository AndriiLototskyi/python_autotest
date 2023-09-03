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
Get API response
	Create Session  GET_LA_DATA     ${Base_URL}
	${json_response}=    GET On Session  GET_LA_DATA     /car/get-not-available-docs/2023/8/GB/12

    ${data_to_string}=   convert to string    ${json_response.content}
    ${content_without_brackets}=        remove string using regexp    ${data_to_string}   ['\\[\\]']
    ${data_to_json}=    convert string to json    ${content_without_brackets}
#    --> For example, we can take TRUE for Budget from the json <--
#    ${data_from_json}=    get value from json    ${data_to_json}  $.pickup_dates.'1'.Budget.'28'
    ${data_from_json}=    get value from json    ${data_to_json}  $.pickup_dates
    ${from_list_to_data}=   get from list     ${data_from_json}   0
    ${from_dictionary_day_1}=     get from dictionary    ${from_list_to_data}     1
    ${from_dictionary_expedia}=     get from dictionary    ${from_dictionary_day_1}     Expedia
    ${from_dictionary_LOK1}=     get from dictionary    ${from_dictionary_expedia}     1

    log to console    ${from_dictionary_LOK1}
*** Keywords ***