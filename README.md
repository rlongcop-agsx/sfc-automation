# SFC Automation Framework

A comprehensive mobile automation testing framework for the SFC+ application using Robot Framework and Appium.

## 📁 Project Structure

```
sfc-automation/
├── 📁 app/                                    # Application files
│   ├── 📁 SFC.app/                           # iOS application bundle
│   └── 📄 application-3544867e-ee97-453b-8693-7bec0aa1aea8.apk  # Android APK
│
├── 📁 data/                                   # Test data and configuration
│   ├── 📁 locators/                          # Element locators
│   │   └── 📄 locators.robot                 # XPath and element selectors
│   └── 📁 variables/                         # Test variables
│       ├── 📄 public_variables.robot         # Public test variables
│       └── 📄 private_variables.robot        # Private/sensitive variables
│
├── 📁 helpers/                               # Python helper modules
│   ├── 📄 handle_emulator.py                 # Emulator/simulator management
│   ├── 📄 handle_request.py                  # API request handling
│   └── 📄 handle_find_app.py                 # Dynamic app path detection
│
├── 📁 logs/                                  # Test execution logs and evidence
│   ├── 📁 android/                           # Android test results
│   │   └── 📁 test_evidence/                 # Screenshots and recordings
│   └── 📁 ios/                               # iOS test results
│       └── 📁 test_evidence/                 # Screenshots and recordings
│
├── 📁 source/                                # Core framework components
│   ├── 📄 common.robot                       # Common keywords and utilities
│   ├── 📄 sfcApp.robot                       # Main application keywords
│   └── 📁 pages/                             # Page Object Model
│       ├── 📄 home.robot                     # Home page keywords
│       └── 📄 login.robot                    # Login page keywords
│
├── 📁 tests/                                 # Test suites
│   └── 📄 fe_sample.robot                    # Sample test cases
│
├── 📁 venv/                                  # Python virtual environment
├── 📄 requirements.txt                       # Python dependencies
└── 📄 README.md                              # This file
```

## 🚀 Features

### Core Capabilities
- **Cross-platform testing** - iOS and Android support
- **Automatic app detection** - Dynamically finds .app and .apk files
- **Screen recording** - Automatic video capture for test evidence
- **Screenshot capture** - Visual test evidence with organized naming
- **Location simulation** - Set device location to Canada for testing
- **Appium server management** - Automatic start/stop of Appium server

### Test Organization
- **Page Object Model** - Organized page-specific keywords
- **Data-driven testing** - Externalized test data and locators
- **Modular framework** - Reusable components and utilities
- **Evidence management** - Organized test artifacts by device type

## 🛠️ Setup Instructions

### Prerequisites
- Python 3.13+
- Robot Framework
- Appium Server
- Android Studio (for Android emulator)
- Xcode (for iOS simulator)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd sfc-automation
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Install Appium**
   ```bash
   npm install -g appium
   ```

### Configuration

1. **Add application files**
   - Place iOS `.app` file in `app/` directory
   - Place Android `.apk` file in `app/` directory
   - Framework automatically detects and uses these files

2. **Configure device settings**
   - Update `data/variables/public_variables.robot` for device configurations
   - Set `DEVICE` variable to `ios` or `android`

## 🧪 Running Tests

### Basic Test Execution
```bash
# Run all tests
robot tests/

# Run specific test file
robot tests/fe_sample.robot

# Run with specific device
robot -v DEVICE:android tests/fe_sample.robot
```

### Test Execution with Tags
```bash
# Run tests with specific tag
robot -i TC-1 tests/fe_sample.robot

# Run tests excluding specific tag
robot -e "slow" tests/fe_sample.robot
```

### Parallel Execution
```bash
# Run tests in parallel (requires pabot)
pabot --processes 2 tests/
```

## 📊 Test Evidence

### Automatic Evidence Collection
- **Screenshots** - Saved as `{device}_{test_tag}.png`
- **Screen recordings** - Saved as `{device}_{test_tag}.mp4`
- **Test reports** - HTML, XML, and log files

### Evidence Location
```
logs/
├── android/
│   └── test_evidence/
│       ├── android_TC-1.png
│       └── android_TC-1.mp4
└── ios/
    └── test_evidence/
        ├── ios_TC-1.png
        └── ios_TC-1.mp4
```

## 🔧 Framework Components

### Core Keywords (`source/common.robot`)
- `Open SFC App` - Launch application
- `Tap Element` - Click elements with retry
- `Input Text To Element` - Enter text with retry
- `Wait For Element To Be Visible` - Wait for elements
- `Validate Element Is Visible` - Verify element presence
- `Get Element Text` - Extract element text
- `Validate Text In Page` - Verify page content

### Emulator Management (`helpers/handle_emulator.py`)
- `Start Appium Server` - Launch Appium server
- `Open Emulator` - Start device emulator
- `Set Location To Canada` - Set device location
- `Close Emulator` - Shutdown emulator
- `Stop Appium Server` - Stop Appium server

### Dynamic App Detection (`helpers/handle_find_app.py`)
- Automatically finds `.app` and `.apk` files
- Sets `ios` and `android` variables
- No manual path configuration needed

## 📝 Test Structure

### Sample Test Case
```robot
*** Test Cases ***
Test Case Sample 1: Validate Landing Page Displayed
    [Documentation]    Validate Landing Page Displayed
    [Tags]    TC-1
    GIVEN The user is on the landing page        ${LANDING_PAGE.cover_page}
    WHEN The user enters the mobile number       ${LANDING_PAGE.mobile_field}    ${PHONE_NUMBER}
    AND The user taps the next button            ${LANDING_PAGE.next_btn}
    THEN The sign-up page should be displayed    Create your SFC+ Account
```

### Page Object Model
- **Locators** - Stored in `data/locators/locators.robot`
- **Page Keywords** - Defined in `source/pages/`
- **Test Data** - Managed in `data/variables/`

## 🔍 Troubleshooting

### Common Issues
1. **Appium connection refused** - Ensure Appium server is running
2. **Emulator not found** - Check device name in variables
3. **App file not found** - Verify .app/.apk files are in app/ directory
4. **Location setting failed** - Check emulator/simulator status

### Debug Mode
```bash
# Run with verbose logging
robot --loglevel DEBUG tests/fe_sample.robot
```

## 🤝 Contributing

1. Follow the existing code structure
2. Add appropriate documentation
3. Include test evidence for new features
4. Update this README for significant changes

## 📄 License

[Add your license information here]

---

**Note:** This framework is designed for the SFC+ mobile application testing. Ensure you have proper authorization before running tests against production environments. 