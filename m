From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  5 Jul 2016 06:04:07 +0200
Subject: [PATCH 0/3] ARM: dts: imx6sx: Initial UDOO Neo enablement
Message-ID: <1467691450-22975-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds initial support for the i.MX 6SoloX based UDOO Neo boards.

First, a typo in another imx6sx board is fixed, found by code review.

The main patch adds an initial set of device trees with serial, LEDs,
Ethernet, I2C and PMIC.

A second patch adds SD card support. This part does not yet work stable,
I keep getting timeouts on next-20160701 with UDOO Neo Basic after varying time.

Regards,
Andreas

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Ettore Chimenti <ettore.chimenti@udoo.org>
Cc: devicetree at vger.kernel.org

Andreas F?rber (3):
  ARM: dts: imx6sx-sabreauto: Fix misspelled property
  ARM: dts: imx6sx: Add UDOO Neo support
  ARM: dts: imx6sx-udoo-neo: Add SD

 arch/arm/boot/dts/Makefile                     |   5 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts         |   2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts    |  69 ++++++
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts |  54 +++++
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts     |  69 ++++++
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi         | 295 +++++++++++++++++++++++++
 6 files changed, 492 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi

-- 
2.6.6
