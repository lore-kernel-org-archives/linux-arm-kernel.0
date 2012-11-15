From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 15 Nov 2012 15:00:10 +0100
Subject: [PATCH 0/4] mx5x usb{misc} devictree bindings and clocks
Message-ID: <1352988014-14769-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik (4):
  ARM: imx: add imx5x usb controller clock lookups
  ARM: imx: add imx5x usbmisc clock lookups
  ARM: dts: imx: rename imx5x usb entries as in imx6q.dtsi
  ARM: dts: imx: add imx5x phy-mode entries

 arch/arm/boot/dts/imx51.dtsi        |   14 ++++++++++----
 arch/arm/boot/dts/imx53.dtsi        |   14 ++++++++++----
 arch/arm/mach-imx/clk-imx51-imx53.c |   30 ++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

-- 
1.7.10.4
