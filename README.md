# ESPHome Installation and Configuration Guide

## Installation

1. **Install ESPHome**
   - Via Docker (recommended for isolation):
     ```bash
     docker pull esphome/esphome
     ```
   - Via Python Pip:
     ```bash
     pip install esphome
     ```

## Configuration

2. **Create a New ESPHome Configuration**
   - Via Docker:
     ```bash
     docker run --rm -v "${PWD}":/config -it esphome/esphome wizard
     ```
   - Via Command Line:
     ```bash
     esphome wizard
     ```

3. **Edit the YAML Configuration**
   - Open the generated `.yaml` file with a text editor.
   - Modify the configuration as per your requirements.

## Compilation

4. **Compile the Firmware**
   - Via Docker:
     ```bash
     docker run --rm -v "${PWD}":/config esphome/esphome <your-config>.yaml compile
     ```
   - Via Command Line:
     ```bash
     esphome <your-config>.yaml compile
     ```

## Firmware Loading

5. **Load the Firmware to the ESP32**
   - Connect the ESP32 board to your Fedora system via USB.
   - Check the USB port (usually `/dev/ttyUSB0` or `/dev/ttyACM0`).
   - Via Docker:
     ```bash
     docker run --rm -v "${PWD}":/config --device=/dev/ttyUSB0 esphome/esphome <your-config>.yaml run
     ```
   - Via Command Line:
     ```bash
     esphome <your-config>.yaml run
     ```

## Additional Notes

- Replace `<your-config>.yaml` with your actual configuration file name.
- Make sure you have necessary permissions to access the USB device (you might need to run the commands with `sudo` or add your user to the `dialout` group).
- If you encounter any issues during compilation or uploading, check for error messages and address them accordingly. This may involve installing additional drivers or troubleshooting USB connection issues.
- Ensure the ESP32 is in bootloading mode if required by your specific board. This often involves holding down a button on the ESP32 while connecting it.

By following these steps, you should be able to bootstrap your ESP32 board with custom firmware and integrate it with your Home Assistant setup.
