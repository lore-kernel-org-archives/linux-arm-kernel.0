From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 26 Mar 2018 23:28:18 +0200
Subject: [PATCH v2 0/2] Add Nintendo NES/SuperNES classic support
Message-ID: <20180326212820.20637-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the NES/SuperNES classic consoles from
Nintendo. Changes are done in A23/A33 DTSI to add NAND support.

Thanks,
Miqu?l

Changes since v1
================

arm: dts: sun8i: a23/a33: declare NAND pins
 * Patch created by splitting the v1 in two
 * Removed the trailing '@0' after the NAND pins declarations
 * Changed the name of these declarations
 * Declared all CS/RB lines
 * Reorganized the pins entry of nand_pins

arm: dts: nes: add Nintendo NES/SuperNES Classic Edition support
 * Created two DTS: nes-classic and supernes-classic
 * Moved the NAND pinctrl declaration into the DTSI
 * Removed the USB hackery explanation
 * Explained why one UART port is preferred to the other


Miquel Raynal (2):
  arm: dts: sun8i: a23/a33: declare NAND pins
  arm: dts: nes: add Nintendo NES/SuperNES Classic Edition support

 arch/arm/boot/dts/Makefile                         |  2 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 29 ++++++++++
 .../boot/dts/sun8i-r16-nintendo-nes-classic.dts    | 62 ++++++++++++++++++++++
 .../dts/sun8i-r16-nintendo-supernes-classic.dts    | 17 ++++++
 4 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-supernes-classic.dts

-- 
2.14.1
