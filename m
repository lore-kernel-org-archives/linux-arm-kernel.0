From: tharvey@gateworks.com (Tim Harvey)
Date: Mon,  8 Sep 2014 23:07:25 -0700
Subject: [PATCH 0/6] ARM: dts: imx: ventana: dt cleanups
Message-ID: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains several clean-ups for the Gateworks Ventana boards
already in mainline largely based on conventions that have become standard
since the patches were originally committed. The final patch also adds
additional support for GW52xx CANbus that was not there previously but
depends on the prior patches.

Tim Harvey (6):
  ARM: dts: imx: ventana: remove unsupported dt nodes
  ARM: dts: imx: ventana: remove unused aliases
  ARM: dts: imx: ventana: use gpio constants
  ARM: dts: imx: ventana: configure padconf for all pins
  ARM: dts: imx: ventana: cleanup pinctrl groups
  ARM: dts: imx: ventana: add canbus support for GW52xx

 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 203 +++++++++-----------
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 192 ++++++++-----------
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 314 +++++++++++++------------------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 338 +++++++++++++---------------------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 278 +++++++++++++---------------
 5 files changed, 542 insertions(+), 783 deletions(-)

-- 
1.8.3.2
