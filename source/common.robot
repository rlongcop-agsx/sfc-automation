*** Settings ***
Library    AppiumLibrary
Library    Dialogs
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot
Library    ../helpers/handle_emulator.py
Library    ../helpers/handle_request.py

*** Comments ***
Main Test Setup: Will execute before each test case
    - Open the emulator
    - Start screen recording
Main Test Teardown: Will execute after each test case
    - Stop screen recording
    - Close the emulator

*** Keywords ***
Open SFC App
    [Arguments]         ${os_type}    ${remote_url}
    Open Application    ${remote_url}    
    ...                 platformName=${PLATFORM_NAME.${os_type}}
    ...                 platformVersion=${PLATFORM_VERSION.${os_type}}
    ...                 deviceName=${DEVICE_NAME.${os_type}}
    ...                 automationName=${AUTOMATION_NAME.${os_type}}
    ...                 app=${APP.${os_type}}
    ...                 autoAcceptAlerts=true
    ...                 autoGrantPermissions=true

Get Test Tag
    ${last_tag}=    Set Variable    ${TEST_TAGS}[-1]
    RETURN    ${last_tag}

Create Test Evidence Directory
    [Arguments]    ${os_type}
    Create Directory    logs/${os_type}/test_evidence

Move Screenshot To Test Evidence
    [Arguments]    ${os_type}    ${last_tag}
    TRY
        ${screenshot_files}=    List Files In Directory    logs/${os_type}    *.png
        IF    ${screenshot_files}
            ${latest_screenshot}=    Set Variable    ${screenshot_files}[-1]
            Move File    logs/${os_type}/${latest_screenshot}    logs/${os_type}/test_evidence/${os_type}_${last_tag}.png
        END
    EXCEPT    AS    ${error}
        Log    Failed to move screenshot: ${error}
    END

Move Recording To Test Evidence
    [Arguments]    ${os_type}    ${last_tag}
    TRY
        ${recording_files}=    List Files In Directory    logs/${os_type}    *.ffmpeg
        IF    not ${recording_files}
            ${recording_files}=    List Files In Directory    logs/${os_type}    *.mp4
        END
        IF    not ${recording_files}
            ${recording_files}=    List Files In Directory    logs/${os_type}    *.webm
        END
        IF    ${recording_files}
            ${latest_recording}=    Set Variable    ${recording_files}[-1]
            Move File    logs/${os_type}/${latest_recording}    logs/${os_type}/test_evidence/${os_type}_${last_tag}.mp4
        END
    EXCEPT    AS    ${error}
        Log    Failed to move recording: ${error}
    END

Main Suite Setup
    [Arguments]        ${device_name}
    handle_emulator.Start Appium Server
    Sleep    5s
    handle_emulator.Open Emulator       ${device_name}
    handle_emulator.Set Location To Canada    ${device_name}

Main Test Setup
    [Arguments]        ${os_type}    ${remote_url}
    Open SFC App       ${os_type}    ${remote_url}
    ${last_tag}=    Get Test Tag
    Create Test Evidence Directory    ${os_type}
    AppiumLibrary.Start Screen Recording    filename=logs/${os_type}/test_evidence/${os_type}_${last_tag}.mp4

Main Test Teardown
    [Arguments]    ${number}    ${os_type}
    ${last_tag}=    Get Test Tag
    Create Test Evidence Directory    ${os_type}
    
    TRY
        AppiumLibrary.Capture Page Screenshot    filename=${os_type}_${last_tag}.png
    EXCEPT    AS    ${error}
        Log    Failed to take screenshot: ${error}
    END
    
    AppiumLibrary.Stop Screen Recording
    
    Move Screenshot To Test Evidence    ${os_type}    ${last_tag}
    Move Recording To Test Evidence    ${os_type}    ${last_tag}
    
    handle_request.Delete Account Number    ${number}

Main Suite Teardown
    [Arguments]        ${device_name}
    handle_emulator.Close Emulator      ${device_name}
    handle_emulator.Stop Appium Server

*** Comments ***
Below are the common keywords that can be used in the test cases.

*** Keywords ***
Tap Element
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    10    1s    Click Element    ${locator}

Input Text To Element
    [Arguments]    ${locator}    ${text}
    Wait Until Keyword Succeeds    10    1s    Input Text    ${locator}    ${text}

Wait For Element To Be Visible
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    ${timeout}

Validate Element Is Visible
    [Arguments]    ${locator}
    Element Should Be Visible    ${locator}

Get Element Text
    [Arguments]    ${locator}
    ${text}=    Wait Until Keyword Succeeds    10    1s    Get Text    ${locator}
    RETURN    ${text}

Validate Text In Page
    [Arguments]    ${text}
    Wait Until Keyword Succeeds    10    1s    Page Should Contain Text    ${text}
