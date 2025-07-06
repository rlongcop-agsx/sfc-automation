*** Settings ***
Resource                private_variables.robot
Variables               ../../helpers/handle_find_app.py

*** Variables ***
${DEVICE}               android
${REMOTE_URL}           http://localhost:4723
&{PLATFORM_NAME}        ios=iOS                android=Android
&{PLATFORM_VERSION}     ios=18.5               android=16
&{DEVICE_NAME}          ios=iPhone 16 Pro      android=emulator-5554
&{AUTOMATION_NAME}      ios=XCUITest           android=UiAutomator2

&{APP}                  ios=${ios}
...                     android=${android}

&{DEVICE_MODEL}          ios=iPhone 16 Pro      android=Galaxy_S22
${PHONE_NUMBER}          8327879836