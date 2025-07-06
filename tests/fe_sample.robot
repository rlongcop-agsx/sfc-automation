*** Settings ***
Resource                ../data/variables/public_variables.robot
Resource                ../source/common.robot
Resource                ../source/sfcApp.robot
Resource                ../data/locators/locators.robot
Suite Setup             Main Suite Setup         ${DEVICE_MODEL.${DEVICE}}
Test Setup              Main Test Setup          ${DEVICE}    ${REMOTE_URL}
Test Teardown           Main Test Teardown       ${PHONE_NUMBER}    ${DEVICE}
Suite Teardown          Main Suite Teardown      ${DEVICE_MODEL.${DEVICE}}

*** Test Cases ***
Test Case Sample 1: Validate Landing Page Displayed
    [Documentation]    Validate Landing Page Displayed
    [Tags]    TC-1
    GIVEN The user is on the landing page        ${LANDING_PAGE.cover_page}
    WHEN The user enters the mobile number       ${LANDING_PAGE.mobile_field}    ${PHONE_NUMBER}
    AND The user taps the next button            ${LANDING_PAGE.next_btn}
    AND The user taps the next button            ${LANDING_PAGE.next_btn}
    THEN The sign-up page should be displayed    Create your SFC+ Account
    