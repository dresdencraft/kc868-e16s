# ESPHome Installation and Configuration Guide

## Setup Development Environment on Linux

**Install ASDF**
   - Via Command Line:
     ```bash
     git clone https://github.com/asdf-vm/asdf.git ~/.asdf
     echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
     source ~/.zshrc
     asdf --version
     ```
**Ensure your user is in the `dialout` group**
- Via Command Line:
   ```bash
   sudo usermod -a -G dialout $USER
   ```

**Install Python**
   - Via ASDF:
     ```bash
     asdf plugin-add python
     asdf install python 3.12.1
     asdf reshim python
     python --version
     ```
**Activate python virtual environment**
- Via Command Line:
   ```bash
   python -m venv venv
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
- Connect the ESP32 board to your linux system via USB.
- Check the USB port (usually `/dev/ttyUSB0` or `/dev/ttyACM0`).
- Check the dmesg output for the USB device connection.
- Via Command Line upload the initial firmware:
    ```bash
    esphome upload --device /dev/ttyUSB0 --file ./.esphome/build/kc868-e16s/.pioenvs/kc868-e16s/firmware-factory.bin kc868-e16s.yaml
    ```
- Once the ESP32 board is configured, it will reboot and connect to your Ethernet network.
- The ESP32 board will be assigned an IP address via DHCP.

# Using the Makefile for Automation

## Environment Variables

Before using the Makefile, you may need to set the following environment variables:

- `USB_DEVICE`: Specifies the USB device path for uploading firmware. Default is `/dev/ttyUSB0`. Set this variable if your device path is different. For example, `export USB_DEVICE=/dev/ttyACM0`.
- `PYTHON_VERSION`: Specifies the Python version for the virtual environment. Default is `3.12.1`. Change this if you need a different Python version.

Example of setting an environment variable:
```bash
export USB_DEVICE=/dev/ttyUSB0
```

## Makefile Targets

- `make configure_asdf`: Installs and configures ASDF.
- `make configure_dialout`: Adds the current user to the `dialout` group.
- `make configure_python`: Sets up the Python virtual environment using the specified Python version.
- `make validate_config`: Validates the ESPHome configuration file.
- `make compile_firmware`: Compiles the ESPHome firmware from the configuration file.
- `make upload_firmware`: Uploads the firmware to the ESP32 device. Requires `USB_DEVICE` to be set if the default is not appropriate.

To run a specific target, use the `make <target>` command. For example, to compile the firmware, run:
```bash
make compile_firmware
```

To execute all steps sequentially, simply run `make` or `make all`. This will configure ASDF, set up Python, validate the configuration, compile the firmware, and upload it to the ESP32 device.
