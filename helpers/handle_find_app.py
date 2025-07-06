import os
import glob

def find_app_files():
    """Automatically finds .app and .apk files in the app folder"""
    app_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'app')
    ios_app = None
    android_app = None
    
    # Find iOS .app file
    ios_pattern = os.path.join(app_dir, '*.app')
    ios_apps = glob.glob(ios_pattern)
    if ios_apps:
        ios_app = ios_apps[0]  # Take the first .app file found
    
    # Find Android .apk file
    android_pattern = os.path.join(app_dir, '*.apk')
    android_apps = glob.glob(android_pattern)
    if android_apps:
        android_app = android_apps[0]  # Take the first .apk file found
    
    return {
        'ios': ios_app,
        'android': android_app
    }

app_files = find_app_files()
ios = app_files['ios']
android = app_files['android']