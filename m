From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 13:36:20 +0800
Subject: [PATCH v2 0/7] Convert mxs board files to device tree
Message-ID: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Drop pwm, backlight and led for m28evk
* Enable enet_out clock for m28evk as well
* Drop the rewriting of tx28_add_fec0 for tx28

Regards,
Shawn

Marek Vasut (1):
  ARM: mxs: convert m28evk board to device tree

Shawn Guo (6):
  ARM: dts: imx28: move extra gpmi-nand pins into board dts
  ARM: dts: imx28: move lcdif control pins into board dts
  ARM: mxs: convert apx4devkit board to device tree
  ARM: mxs: convert tx28 board to device tree
  ARM: mxs: convert stmp378x_devb board to device tree
  ARM: mxs: add dtb-y target into Makefile.boot

 arch/arm/boot/dts/apx4devkit.dts    |  143 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-evk.dts     |   30 +++++-
 arch/arm/boot/dts/imx28.dtsi        |   86 +++++++++++++-
 arch/arm/boot/dts/m28evk.dts        |  210 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stmp378x_devb.dts |   78 +++++++++++++
 arch/arm/boot/dts/tx28.dts          |   82 ++++++++++++++
 arch/arm/mach-mxs/Makefile.boot     |    9 ++
 arch/arm/mach-mxs/mach-mxs.c        |   67 ++++++++++-
 8 files changed, 692 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/apx4devkit.dts
 create mode 100644 arch/arm/boot/dts/m28evk.dts
 create mode 100644 arch/arm/boot/dts/stmp378x_devb.dts
 create mode 100644 arch/arm/boot/dts/tx28.dts

-- 
1.7.5.4
