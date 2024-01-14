# Variables
USB_DEVICE ?= /dev/ttyUSB0
PYTHON_VERSION = 3.12.1
CONFIG_FILE = kc868-e16s.yaml

# Default target
all: configure_asdf configure_python validate_config compile_firmware

# Install ASDF
configure_asdf_with_zsh:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	echo -e '\n. $$HOME/.asdf/asdf.sh' >> ~/.zshrc
	source ~/.zshrc
	asdf --version

configure_asdf_with_bash:
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	echo -e '\n. $$HOME/.asdf/asdf.sh' >> ~/.bashrc
	source ~/.bashrc
	asdf --version

# Add user to dialout group
configure_dialout:
	sudo usermod -a -G dialout $$USER

# Setup Python Environment
configure_python:
	asdf plugin-add python
	asdf install python $(PYTHON_VERSION)
	asdf reshim python
	python -m venv venv
	source venv/bin/activate

# Validate ESPHome Configuration
validate_config:
	esphome config $(CONFIG_FILE)

# Compile ESPHome Firmware
compile_firmware:
	esphome compile $(CONFIG_FILE)

# Upload Firmware to ESP32
upload_firmware:
	esphome upload --device $(USB_DEVICE) --file ./.esphome/build/$(CONFIG_FILE)/.pioenvs/$(CONFIG_FILE)/firmware.bin $(CONFIG_FILE)

# Help
help:
	@echo "Available targets:"
	@echo "  configure_asdf    : Install and configure ASDF"
	@echo "  configure_dialout : Add user to dialout group"
	@echo "  configure_python  : Setup Python environment"
	@echo "  validate_config   : Validate ESPHome configuration"
	@echo "  compile_firmware  : Compile ESPHome firmware"
	@echo "  upload_firmware   : Upload firmware to ESP32 device"
	@echo "  all               : Perform all steps"
	@echo "Usage:"
	@echo "  make <target> [USB_DEVICE=<device_path>]"
