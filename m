From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Sep 2016 17:02:27 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.9
In-Reply-To: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1473670948-4265-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.9

for you to fetch changes up to e5f51a623a5d6dd24779e5136cf923611b032453:

  arm64: dts: ls2080a: Add 'dma-coherent' for ls2080a PCI nodes (2016-09-09 14:04:21 +0800)

----------------------------------------------------------------
i.MX arm64 device tree changes for 4.9:
 - Add property dma-coherent for ls2080a PCI device to save software
   cache maintenance.
 - Update serial aliases and use stdout-path to sepecify console for
   ls2080a and ls1043a boards.
 - Add DDR memory controller device node for ls2080a and ls1043a SoCs.

----------------------------------------------------------------
Liu Gang (1):
      arm64: dts: ls2080a: Add 'dma-coherent' for ls2080a PCI nodes

Stuart Yoder (2):
      arm64: dts: updates serial aliases for ls1043a rdb and qds boards
      arm64: dts: add stdout-path to chosen node for ls2080a/ls1043a boards

York Sun (1):
      arm64: dts: Add DDR memory controller for Layerscape SoCs

 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 14 ++++++++------
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    |  7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts |  3 +++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi    | 18 ++++++++++++++++++
 6 files changed, 48 insertions(+), 6 deletions(-)
