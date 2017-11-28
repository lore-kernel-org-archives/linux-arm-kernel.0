From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 28 Nov 2017 21:29:23 +0800
Subject: [PATCH 0/3] spicc: meson-axg: add SPICC controller
Message-ID: <20171128132926.19051-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPICC controller driver to the Amlogic's Meson-AXG SoC.
The new compatible string introduced here is aiming for adding
a few new features which found at the Meson-AXG platform.

Sunny Luo (3):
  dt-bindings: spicc: update compatible string for the Meson-AXG
  spi: meson-axg: add SPICC driver support
  ARM64: dts: meson-axg: add the SPICC controller

 .../devicetree/bindings/spi/spi-meson.txt          |  4 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 92 ++++++++++++++++++++++
 drivers/spi/spi-meson-spicc.c                      |  1 +
 3 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.15.0
