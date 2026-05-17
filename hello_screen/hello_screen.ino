#include <Arduino_GFX_Library.h>

// Official Waveshare ESP32-S3-Touch-LCD-1.28 pins (Setup302)
#define TFT_BL   2
#define TFT_DC   8
#define TFT_CS   9
#define TFT_CLK  10
#define TFT_MOSI 11
#define TFT_RST  14

// Software SPI - bypasses all hardware SPI bus configuration issues
Arduino_DataBus *bus = new Arduino_SWSPI(TFT_DC, TFT_CS, TFT_CLK, TFT_MOSI, GFX_NOT_DEFINED);
Arduino_GFX *gfx = new Arduino_GC9A01(bus, TFT_RST, 0, false);

void setup() {
  pinMode(TFT_BL, OUTPUT);
  digitalWrite(TFT_BL, HIGH);

  gfx->begin();
  gfx->fillScreen(RGB565_BLACK);
  gfx->setTextColor(RGB565_WHITE);
  gfx->setTextSize(4);
  gfx->setCursor(40, 100);
  gfx->print("Hello");
  gfx->setCursor(55, 140);
  gfx->print("Alex");
}

void loop() {}
