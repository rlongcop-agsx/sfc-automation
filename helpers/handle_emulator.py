import subprocess, logging, time, os, signal, psutil

logging.basicConfig(
    level=logging.INFO,                     
    format='%(asctime)s %(levelname)s %(message)s'
)

def is_ios_simulator(device_name):
    result = subprocess.run(
        ["xcrun", "simctl", "list", "devices"],
        capture_output=True,
        text=True
    )
    return device_name in result.stdout

def wait_for_emulator(device_name: str = "", timeout: int = 300) -> bool:
    """
    Wait for emulator/simulator to be fully booted and ready.
    Returns True if successful, False if timeout reached.
    """
    start_time = time.time()
    
    if is_ios_simulator(device_name):
        logging.info(f"Waiting for iOS simulator '{device_name}' to be ready...")
        while time.time() - start_time < timeout:
            # Check if simulator is booted and in "Booted" state
            result = subprocess.run(
                ["xcrun", "simctl", "list", "devices", device_name],
                capture_output=True,
                text=True
            )
            if "(Booted)" in result.stdout:
                logging.info("iOS simulator is ready!")
                return True
            time.sleep(5)
    else:
        logging.info("Waiting for Android emulator to be ready...")
        while time.time() - start_time < timeout:
            result = subprocess.run(
                ["adb", "shell", "getprop", "sys.boot_completed"],
                capture_output=True,
                text=True
            )
            if result.stdout.strip() == "1":
                logging.info("Android emulator is ready!")
                return True
            time.sleep(5)
    
    logging.error(f"Timeout reached after {timeout} seconds")
    return False

def open_emulator(device_name):
    if is_ios_simulator(device_name):
        subprocess.run(["xcrun", "simctl", "boot", device_name])
        subprocess.run(["open", "-a", "Simulator"])
    else:
        subprocess.Popen(["emulator", "-avd", device_name])
    
    if not wait_for_emulator(device_name):
        raise RuntimeError("Failed to start emulator/simulator")
    
def close_emulator(device_name=""):
    logging.info("Closing emulator...")
    if is_ios_simulator(device_name):
        logging.info("iOS detected, shutting down simulator.")
        subprocess.run(["xcrun", "simctl", "shutdown", device_name])
    else:
        logging.info("Android detected, killing emulator.")
        subprocess.run(["adb", "emu", "kill"])
        subprocess.run(["pkill", "-9", "qemu"])
    
def start_appium_server():
    """Starts Appium server as a background process"""
    try:
        # Start Appium server (non-blocking)
        appium_process = subprocess.Popen(
            ["appium"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        logging.info("Appium server started (PID: %d)", appium_process.pid)
        return appium_process
    except Exception as e:
        logging.error("Failed to start Appium: %s", e)
        raise

def stop_appium_server():
    """Stops all running Appium server processes."""
    for proc in psutil.process_iter(['pid', 'name', 'cmdline']):
        try:
            if 'appium' in ' '.join(proc.info['cmdline']):
                os.kill(proc.info['pid'], signal.SIGTERM)
                logging.info(f"Stopped Appium server (PID: {proc.info['pid']})")
        except Exception as e:
            continue

def set_location_to_canada(device_name=""):
    """Sets the emulator/simulator location to Canada (Toronto coordinates)"""
    try:
        if is_ios_simulator(device_name):
            # iOS Simulator - Toronto, Canada coordinates
            subprocess.run([
                "xcrun", "simctl", "location", device_name, "set", 
                "43.6532,-79.3832"  # Toronto coordinates as single string
            ])
            logging.info(f"Set iOS simulator '{device_name}' location to Toronto, Canada")
        else:
            # Android Emulator - Toronto, Canada coordinates
            subprocess.run([
                "adb", "emu", "geo", "fix", "-79.3832", "43.6532"
            ])
            logging.info("Set Android emulator location to Toronto, Canada")
    except Exception as e:
        logging.error(f"Failed to set location: {e}")
        raise
