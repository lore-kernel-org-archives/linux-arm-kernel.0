From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 15:47:56 +0800
Subject: [GIT PULL] mxs device tree changes for 3.6 (part 2)
Message-ID: <20120712074755.GL6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is the second (last) batch of mxs mxs device tree changes for 3.6.
Please pull.

Regards,
Shawn

The following changes since commit 6ca44acfc31ad485b18e2fca0428479b7d4f141d:

  ARM: dts: imx28-evk: add flexan devices (2012-07-06 13:26:05 +0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt-for-3.6

Lauri Hintsala (6):
      ARM: apx4devkit: add NAND support
      ARM: apx4devkit: add display support
      ARM: apx4devkit: fix the bus-width of SSP0 to 4 bits
      ARM: apx4devkit: add SSP2 support
      ARM: apx4devkit: remove AUART3
      ARM: apx4devkit: add pin muxing for GPIOs

Marek Vasut (1):
      ARM: mxs: convert m28evk board to device tree

Richard Zhao (1):
      ARM: dts: imx28-evk: add usb devices

Shawn Guo (7):
      ARM: dts: imx28: move extra gpmi-nand pins into board dts
      ARM: dts: imx28: move lcdif control pins into board dts
      ARM: mxs: convert apx4devkit board to device tree
      ARM: mxs: convert tx28 board to device tree
      ARM: mxs: convert stmp378x_devb board to device tree
      ARM: mxs: add dtb-y target into Makefile.boot
      ARM: mxs: rename dts files with soc name being the prefix

 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |   78 ++++++++
 arch/arm/boot/dts/imx28-apx4devkit.dts             |  198 ++++++++++++++++++
 .../boot/dts/{cfa10036.dts => imx28-cfa10036.dts}  |    0
 arch/arm/boot/dts/imx28-evk.dts                    |   68 ++++++-
 arch/arm/boot/dts/imx28-m28evk.dts                 |  210 ++++++++++++++++++++
 arch/arm/boot/dts/imx28-tx28.dts                   |   97 +++++++++
 arch/arm/boot/dts/imx28.dtsi                       |   98 +++++++++-
 arch/arm/mach-mxs/Makefile.boot                    |    9 +
 arch/arm/mach-mxs/mach-mxs.c                       |   87 ++++++++-
 9 files changed, 831 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx23-stmp378x_devb.dts
 create mode 100644 arch/arm/boot/dts/imx28-apx4devkit.dts
 rename arch/arm/boot/dts/{cfa10036.dts => imx28-cfa10036.dts} (100%)
 create mode 100644 arch/arm/boot/dts/imx28-m28evk.dts
 create mode 100644 arch/arm/boot/dts/imx28-tx28.dts
