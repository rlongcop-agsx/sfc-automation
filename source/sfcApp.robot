*** Settings ***
Resource    pages/home.robot
Resource    pages/login.robot
Resource    common.robot

*** Keywords ***

The user is on the landing page
    [Arguments]    ${locator}
    common.Validate Element Is Visible    ${locator}

The user enters the mobile number
    [Arguments]    ${locator}    ${text}
    common.Input Text To Element    ${locator}    ${text}

The user taps the next button
    [Arguments]    ${locator}
    common.Tap Element    ${locator}

The user should be navigated to the OTP page
    [Arguments]    ${locator}
    common.Validate Element Is Visible    ${locator}

The sign-up page should be displayed
    [Arguments]    ${text}
    common.Validate Text In Page    ${text}
    


