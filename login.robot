*** Settings ***
Documentation  Login Functionality
Library  SeleniumLibrary

*** Variables ***

*** Test Cases ***
Verify Successful Login to FornovaMI
    [documentation]  This test case verifies that user is able to successfully Login to FornovaMI
    [tags]  Smoke
    Open Browser  https://ci-dev.fornova.com/  Chrome
    Wait Until Element Is Visible  css:input[class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']  timeout=5
    Input Text  css:input[class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']
    Input Password  css:input[class='form-control icon icon-pass ng-untouched ng-pristine ng-invalid']  
    Click Element  css:button[type='submit']
    Wait Until Element Is Visible  css:div[class='header__left__logo']  timeout=10
    Element Should Be Visible  css:div[class='header__left__logo']

Verify Successful Logout from FornovaMI
    [documentation]  This test case verifies that user is able to successfully Logout from FornovaMI
    [tags]  Smoke
    Wait Until Element Is Visible  css:div[class='profile-menu__label']  timeout=2
    Click Element  //div[@class='profile-menu__label']
    Click Element  //span[@class='profile-menu__item']//span[contains(text(),'Log Out')]
    Wait Until Element Is Visible  //input[@class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']  timeout=10
    Element Should Be Visible  //input[@class='form-control icon icon-email ng-untouched ng-pristine ng-invalid']
    Close Browser


*** Keywords ***