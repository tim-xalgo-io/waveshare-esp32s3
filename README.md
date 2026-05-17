# Waveshare ESP32-S3-Touch-LCD-1.28

Arduino sketches for the [Waveshare ESP32-S3-Touch-LCD-1.28](https://www.waveshare.com/wiki/ESP32-S3-Touch-LCD-1.28) — a round 240×240 GC9A01 LCD with capacitive touch, built around the ESP32-S3.

## Hardware

| Function | GPIO |
|----------|------|
| LCD DC   | 8    |
| LCD CS   | 9    |
| LCD CLK  | 10   |
| LCD MOSI | 11   |
| LCD RST  | 14   |
| Backlight | 2   |

USB-to-UART: WCH CH343 (appears as `/dev/cu.usbmodem*` on macOS)

## Prerequisites

**arduino-cli**
```
brew install arduino-cli
arduino-cli core install esp32:esp32
arduino-cli lib install "GFX Library for Arduino"
```

**esptool** (via pip)
```
pip3 install esptool --index-url https://pypi.org/simple/
```

> **macOS note:** The CH343 USB-UART chip requires patched esptool settings to
> work around data corruption in the macOS generic CDC driver. The Makefile
> already applies these (`--no-stub`, 128-byte write blocks, 10 ms inter-block
> delay). You do _not_ need to install the WCH kernel extension.

## Compile & Flash

```
make              # compile + flash (default target)
make build        # compile only
make flash        # compile + flash
make monitor      # open serial monitor at 115200 baud
make clean        # remove build artefacts
```

The default sketch is `hello_screen`. To build a different sketch, override `SKETCH`:

```
make SKETCH=hello_serial
```

To use a different serial port:

```
make PORT=/dev/cu.usbmodem56F20358991
```

## Sketches

| Sketch | Description |
|--------|-------------|
| `hello_screen` | Draws "Hello Alex" on the round LCD |
| `hello_serial` | Prints "Hello" over UART every second |

## Flashing manually

If `make flash` fails, put the board into bootloader mode first:
hold **BOOT**, press and release **RESET**, then release **BOOT** — then re-run `make flash`.
