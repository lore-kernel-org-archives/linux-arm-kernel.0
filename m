From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:28:20 +0200
Subject: [PATCH 0/5] ARM64: dts: meson: Add CEC,
 Ethernet Link and SPI pins nodes
Message-ID: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the following DT Pins nodes :
 - CEC Pins for GXBB and GXL
 - SPICC Pins for GXBB and GXL
 - Internal Ethernet PHY LEDS pins for GXL

Neil Armstrong (5):
  ARM64: dts: meson-gxbb: Add CEC pins nodes
  ARM64: dts: meson-gxl: Add CEC pins nodes
  ARM64: dts: meson-gxl: Add Ethernet PHY LEDS pins nodes
  ARM64: dts: meson-gxbb: Add SPI pinctrl nodes
  ARM64: dts: meson-gxl: Add SPI pinctrl nodes

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 30 ++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 44 +++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

-- 
1.9.1
