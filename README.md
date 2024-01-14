# ESPHome Installation and Configuration Guide

## Setup Development Environment

**Ensure your user is in the `dialout` group**
   ```bash
   sudo usermod -a -G dialout $USER
   ```

**Activate python virtual environment**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

## Install ESPHome

**Install ESPHome**
   - Via Python Pip:
     ```bash
     pip install esphome
     ```

## Configuration

- Edit the `kc868-e16s.yaml` file to configure your ESP32 board.
- Modify the configuration as per your requirements.
- Refer to the [ESPHome documentation](https://esphome.io/) for more information on configuration.  

## Compilation

1. **Validate the Configuration**
   - Via Command Line:
     ```bash
     esphome config kc868-e16s.yaml
     ```

2. **Compile the Firmware**
   - Via Command Line:
     ```bash
     esphome compile kc868-e16s.yaml
     ```

## Firmware Loading

**Initial Bootstrap of the ESP32 device**
- This step is only required for the initial setup of the ESP32 board.
- Via Command Line open a dmesg session:
    ```bash
    dmesg -w
    ```
- Connect the ESP32 board to your Fedora system via USB.
- Check the USB port (usually `/dev/ttyUSB0` or `/dev/ttyACM0`).
- Check the dmesg output for the USB device connection.
- Via Command Line upload the initial firmware:
    ```bash
    esphome upload --device /dev/ttyUSB0 --file ./.esphome/build/kc868-e16s/.pioenvs/kc868-e16s/firmware.bin kc868-e16s.yaml
    ```
- Once the ESP32 board is configured, it will reboot and connect to your Ethernet network.
- The ESP32 board will be assigned an IP address via DHCP.

