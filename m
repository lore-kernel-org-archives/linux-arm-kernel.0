From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Sat, 20 Feb 2016 11:20:48 +0100
Subject: [PATCH 0/4] Add support for Engicam IMX6UL module
Message-ID: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thi patch series add the support for Engicam IMXUL product

https://community.freescale.com/docs/DOC-328428

Based on Freescale? i.MX 6UltraLite processor, a high performance,
ultra-efficient processor family featuring an advanced implementation
of a single ARM? Cortex?-A7 core, which operates at speeds up to 528 MHz.

The new ENGICAM GEA M6UL module is suitable for cost effective HMI
applications requiring high performance CPU.

Michael Trimarchi (4):
  ARM: dts: imx6ul: Add flexcan1 and flexcan2 support
  ARM: dts: imx6ul: Add LCDIF support
  ARM: dts: imx6ul: Add GPMI nand controller support
  ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/imx6ul-geam-kit.dts  | 102 +++++++++
 arch/arm/boot/dts/imx6ul-geam.dtsi     | 371 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi          |  68 ++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |  10 +
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |   6 +-
 6 files changed, 557 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-geam-kit.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-geam.dtsi

-- 
2.7.0
