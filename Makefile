FQBN     := esp32:esp32:esp32s3
PORT     := /dev/cu.usbmodem56F20358991
BAUD     := 115200
SKETCH   := hello_screen
BUILD    := /tmp/$(SKETCH)_build
ESPTOOL  := python3 -m esptool
PARTITIONS := $(HOME)/Library/Arduino15/packages/esp32/hardware/esp32/3.3.8/tools/partitions/boot_app0.bin

FLASH_FLAGS := --chip esp32s3 --port $(PORT) --baud $(BAUD) \
	--before default_reset --after hard_reset --no-stub \
	write_flash --flash_mode keep --flash_freq keep --flash_size keep

.PHONY: all build flash monitor clean

all: flash

build:
	arduino-cli compile --fqbn $(FQBN) --output-dir $(BUILD) $(SKETCH)

flash: build
	$(ESPTOOL) $(FLASH_FLAGS) \
		0x0     $(BUILD)/$(SKETCH).ino.bootloader.bin \
		0x8000  $(BUILD)/$(SKETCH).ino.partitions.bin \
		0xe000  $(PARTITIONS) \
		0x10000 $(BUILD)/$(SKETCH).ino.bin

monitor:
	python3 -c "\
import serial, time; \
s = serial.Serial('$(PORT)', $(BAUD), timeout=5); \
[print(s.readline().decode('utf-8','replace').strip()) for _ in iter(int,1)]"

clean:
	rm -rf $(BUILD)
