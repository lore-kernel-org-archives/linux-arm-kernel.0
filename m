From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  3 May 2016 23:58:04 +0800
Subject: [GIT PULL 4/6] Freescale/NXP arm64 device tree updates for 4.7
In-Reply-To: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
References: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1462291086-19925-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.7

for you to fetch changes up to bb4b4e93febc139003e2af2f36e438df58b4803c:

  arm64: dts: ls2080a: fsl-mc dt node updates (2016-04-26 11:25:44 +0800)

----------------------------------------------------------------
The Freescale/NXP arm64 device tree updates for 4.7:
 - New board support of LS1043a-QDS from Freescale/NXP
 - Add new compatible for LS1043A and LS2080A GPIO devices
 - Update device tree bindings and sources for LS2080A fsl-mc device
 - Update QSPI and DSPI support on LS1043A and LS2080A

----------------------------------------------------------------
Hou Zhiqiang (1):
      Documentation: DT: Add entry for Freescale LS1043a-QDS board

Liu Gang (2):
      arm64: dts: ls1043a: Add compatible "fsl,qoriq-gpio" for ls1043a gpio nodes
      arm64: dts: ls2080a: Add compatible "fsl,ls2080a-gpio" for ls2080a gpio nodes

Shaohui Xie (1):
      arm64: dts: add LS1043a-QDS board support

Stuart Yoder (2):
      Documentation: fsl-mc: binding updates for MSIs, ranges, PHYs
      arm64: dts: ls2080a: fsl-mc dt node updates

Yuan Yao (4):
      Documentation: fsl: dspi: Add fsl,ls2080a-dspi compatible string
      arm64: dts: ls2080a: update the DTS for QSPI and DSPI support
      Documentation: fsl-quadspi: Add fsl,ls1043a-qspi compatible string
      arm64: dts: ls1043a: add the DTS node for QSPI support

Yunhui Cui (1):
      arm64: dts: ls1043a-rdb: add the DTS for DSPI support

 Documentation/devicetree/bindings/arm/fsl.txt      |   4 +
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  81 ++++++++-
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   3 +-
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |   5 +-
 arch/arm64/boot/dts/freescale/Makefile             |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 181 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  13 ++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  22 ++-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |   9 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 110 ++++++++++++-
 10 files changed, 416 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
