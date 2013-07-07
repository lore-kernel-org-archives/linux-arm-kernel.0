From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Jul 2013 15:13:28 +0200
Subject: [PATCH 0/3] ARM: dts: imx27 phyCARD-S I2C devices
Message-ID: <1373202811-13825-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here are some I2C device patches for phyCARD-S.

Regards,

Markus


Markus Pargmann (3):
      ARM: dts: imx27 phyCARD-S SOM remove wrong i2c sensor
      ARM: dts: imx27 phyCARD-S, move i2c1 and owire to rdk
      ARM: dts: imx27 phyCARD-S, i2c ADC device node

 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 31 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 23 ------------------
 2 files changed, 31 insertions(+), 23 deletions(-)
