From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu,  3 Dec 2015 16:10:29 -0500
Subject: [PATCH v5 0/7] ARM: dts: Add Advantech board support
Message-ID: <1449177036-13317-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add Advantech BA-16 module (iMX6 based) and GE board support.

This series has been tested against linux-next tag next-20151202.

Modifications:
v4->v5:
- BA16: Move SPI FLASH partitions to a "partitions" subnode
- B450v3, B650v3 and B850v3: Fix model names

History:
--------
[v1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381872.html
[v2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383276.html
[v3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384202.html
[v4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390373.html

Akshay Bhat (5):
  of: Add vendor prefix for Advantech Corporation
  of: Add vendor prefix for General Electric Company
  ARM: dts: imx: Add support for Advantech/GE B450v3
  ARM: dts: imx: Add support for Advantech/GE B650v3
  ARM: dts: imx: Add support for Advantech/GE B850v3

Justin Waters (2):
  ARM: dts: imx: Add Advantech BA-16 Qseven module
  ARM: dts: imx: Add support for Advantech/GE Bx50v3

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  84 +++
 arch/arm/boot/dts/imx6q-b650v3.dts                 |  84 +++
 arch/arm/boot/dts/imx6q-b850v3.dts                 | 127 +++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  | 589 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                | 207 ++++++++
 7 files changed, 1096 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi

-- 
2.6.3
