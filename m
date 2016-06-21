From: andrej@inversepath.com (andrej at inversepath.com)
Date: Tue, 21 Jun 2016 16:50:51 +0200
Subject: [PATCH 0/2] ARM: dts: imx53: add support for USB armory board
Message-ID: <20160621145053.7742-1-andrej@inversepath.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrej Rosano <andrej@inversepath.com>

This two patches add support for the USB armory board.

The USB armory from Inverse Path is an open source hardware design,
implementing a flash drive sized computer:
https://inversepath.com/usbarmory

Andrej Rosano (2):
  devicetree: Add vendor prefix for Inverse Path
  ARM: dts: imx53: add support for USB armory board

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx53-usbarmory.dts              | 239 +++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-usbarmory.dts

-- 
2.9.0
