From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Tue, 10 Nov 2015 13:00:01 -0500
Subject: [PATCH v3 0/7] ARM: dts: Add Advantech board support
Message-ID: <1447178408-26982-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add Advantech BA-16 module (iMX6 based) and GE board support.

This series has been tested against linux-next tag next-20151110.

Modifications:
v2->v3:
- Change vendor prefix from adv to advantech as suggested by Rob Herring
- Reorder patches and squash/fold v2 commits as suggested by Lucas Stash

History:
--------
[v1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381872.html
[v2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383276.html

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
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  75 +++
 arch/arm/boot/dts/imx6q-b650v3.dts                 |  74 +++
 arch/arm/boot/dts/imx6q-b850v3.dts                 | 122 +++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  | 584 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                | 211 ++++++++
 7 files changed, 1071 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b450v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b650v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-bx50v3.dtsi

-- 
2.6.3
