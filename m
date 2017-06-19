From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 19 Jun 2017 11:04:37 +0200
Subject: [PATCH v2 0/3] ARM64: dts: meson-gxl: Add support for Libre
 Technology CC board
Message-ID: <20170619090440.27099-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the CC board from Shenzhen Libre Technology

This board derives from the s905x p212 reference design. it provides:
* Ethernet using the internal PHY
* 4 USB ports
* Composite Audio/Video jack
* HDMI
* IR

It also provides 2 Headers (40 and 8 pins) for GPIOs and the following
functions:
* 2 i2c busses
* SPI
* SDIO
* I2S 8ch output
* PWMs
* UART with HW flow control
* PCM
* 2 ADC Channels

Changes since v1: [0]
 - Fixup confusion between the manufacturer name and the device name.

[0]: https://lkml.kernel.org/r/20170616120648.23320-1-jbrunet at baylibre.com

Jerome Brunet (3):
  dt-bindings: add Libre Technology vendor prefix
  dt-bindings: arm: amlogic: Add Libre Technology CC board
  ARM64: dts: meson-gxl: Add Libre Technology CC support

 Documentation/devicetree/bindings/arm/amlogic.txt  |  1 +
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 92 ++++++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts

-- 
2.9.4
