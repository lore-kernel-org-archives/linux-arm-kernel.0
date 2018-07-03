From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  3 Jul 2018 15:21:47 +0200
Subject: [PATCH 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
Message-ID: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clocks frequency in the order of the MHz.

Thsi patchset includes the dt-bindings, driver and the DT node added to the
meson-gx dtsi.

Neil Armstrong (3):
  soc: amlogic: Add Meson GX Clock Measure driver
  dt-bindings: amlogic: Add Internal Clock Measurer bindings
  ARM64: dts: meson-gx: Add Internal Clock Measurer node

 .../bindings/soc/amlogic/clk-measure.txt           |  15 ++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   5 +
 drivers/soc/amlogic/Kconfig                        |   8 +
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-gx-clk-measure.c         | 224 +++++++++++++++++++++
 5 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c

-- 
2.7.4
