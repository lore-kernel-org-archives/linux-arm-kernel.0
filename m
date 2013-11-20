From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 20 Nov 2013 09:45:47 +0100
Subject: [PATCH v8 0/4] pinctrl: imx27: imx27 pincontrol driver
Message-ID: <1384937151-11160-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This version has some commit message updates. It still depends on the pinctrl driver patch [1].

Regards,

Markus

[1] [PATCH] pinctrl: imx1-core populate subdevices
    <1384193987-20740-1-git-send-email-mpa@pengutronix.de>
    http://thread.gmane.org/gmane.linux.drivers.devicetree/51584


Changes in v8:
 - Update commit messages to describe updated patch content

Changes in v7:
 - Added patch for imx27-pingrp.h
 - Pin nodes moved to board dts files
 - gpio nodes in imx27.dtsi moved to iomux node


Markus Pargmann (4):
  ARM: dts: imx27 iomux device node
  ARM: dts: imx27 phyCARD-S pinctrl
  ARM: dts: imx27 phycore move uart1 to rdk
  ARM: dts: imx27 phycore pinctrl

 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts |  43 ++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts |  16 +++
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts   |  23 +++++
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts   |  20 +++-
 arch/arm/boot/dts/imx27.dtsi                     | 125 ++++++++++++-----------
 5 files changed, 165 insertions(+), 62 deletions(-)

-- 
1.8.4.2
