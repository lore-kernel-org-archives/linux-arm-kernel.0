From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 17 Nov 2017 16:02:31 +0800
Subject: [PATCH 0/5] i2c: meson-axg: add I2C controller driver
Message-ID: <20171117080236.32504-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set try to add I2C controller driver for
the Amlogic's Meson-AXG SoC.

Jian Hu (5):
  dt-bindings: i2c: update documentation for the Meson-AXG
  i2c: meson: add configurable divider factors
  ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
  ARM64: dts: meson-axg: describe pin DT info for I2C controller
  ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker

 .../devicetree/bindings/i2c/i2c-meson.txt          |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   6 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 123 +++++++++++++++++++++
 drivers/i2c/busses/i2c-meson.c                     |  32 +++++-
 4 files changed, 158 insertions(+), 4 deletions(-)

-- 
2.14.1
