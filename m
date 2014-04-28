From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 16:12:33 +0200
Subject: [PATCH 0/3] ARM: dts: imx6 fsl-ssi and i2c4
Message-ID: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here are some patches for imx6 dtsi files for fsl-ssi and i2c4. The first patch
removes some unused properties (fsl,ssi-dma-events). The second patch adds
clock-names for all imx6 ssi nodes. The third patch fixes i2c4.

Regards,

Markus


Markus Pargmann (3):
  arm: dts: imx6qdl, remove fsl,ssi-dma-events
  arm: dts: imx6* Add clock-names for all ssi nodes
  ARM: dts: imx6dl, fix i2c4 device node

 arch/arm/boot/dts/imx6dl.dtsi  | 3 ++-
 arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.9.1
