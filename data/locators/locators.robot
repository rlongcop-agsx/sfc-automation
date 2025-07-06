*** Variables ***
&{LANDING_PAGE}
...    cover_page=xpath=(//XCUIElementTypeOther[@name="Shop Exclusives Discover curated deals and special offers from Seafood City and partner merchants."])[1]
...    next_btn=xpath=//XCUIElementTypeButton[@name="Next"]
...    country_code=xpath=//XCUIElementTypeOther[@name=" XXXXXXXXXX"]/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeButton/XCUIElementTypeOther
...    mobile_field=//XCUIElementTypeOther[@name="XXXXXXXXXX"]

&{OTP_PAGE}
...    otp_page=xpath=//XCUIElementTypeStaticText[@name="Enter your PIN"]
