From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 11 Apr 2013 12:13:13 +0200
Subject: [PATCH 0/4] ARM: dts: imx: basic dts for mx5x
Message-ID: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds basic usb support for the qsb.

Michael Grzeschik (4):
  ARM: dts: imx: add imx5x usbmisc entries
  ARM: dts: imx: add imx5x usb clock DT lookups
  ARM: dts: imx: use usb-nop-xceiv usbphy entries for imx5x
  ARM: dts: imx: imx53-qsb.dts: enable usbotg and usbh1

 arch/arm/boot/dts/imx51.dtsi    | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/imx53-qsb.dts |  8 ++++++++
 arch/arm/boot/dts/imx53.dtsi    | 31 +++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

-- 
1.8.2.rc2
