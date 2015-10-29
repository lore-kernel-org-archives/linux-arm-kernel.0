From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 29 Oct 2015 19:16:41 -0400
Subject: [PATCH 0/6] ARM: dts: Add Advantech board support
Message-ID: <1446160607-16053-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add Advantech BA-16 module (iMX6 based) and board support.

Module details:
http://www2.advantech.com/products/computer-on-module/rom-7420/mod_a091469f-b4b1-4929-be51-a9237d5ba40a.aspx

This series has been tested against linux-next tag next-20151022.

Akshay Bhat (4):
  of: Add vendor prefix for Advantech Corporation
  ARM: dts: imx: Add support for Advantech/GE B450v3
  ARM: dts: imx: Add support for Advantech/GE B650v3
  ARM: dts: imx: Add support for Advantech/GE B850v3

Justin Waters (2):
  ARM: dts: imx: Add Advantech BA-16 Qseven module
  ARM: dts: imx: Add support for Advantech/GE Bx50v3

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  75 +++
 arch/arm/boot/dts/imx6q-b650v3.dts                 |  74 +++
 arch/arm/boot/dts/imx6q-b850v3.dts                 | 122 +++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  | 559 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                | 206 ++++++++
 7 files changed, 1040 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi

-- 
2.6.2
