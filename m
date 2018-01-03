From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  3 Jan 2018 13:57:19 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.16
In-Reply-To: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
References: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1514959040-9992-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.16

for you to fetch changes up to 1e33300782235ae6fdc891d9c3ba04ba59da6f3d:

  arm64: dts: ls208xa: add power monitor chip node (2017-12-26 17:14:13 +0800)

----------------------------------------------------------------
Freescale arm64 device tree updates for 4.16:
 - LS1088A updates: add device support for DCFG, qoriq-mc, and USB.
 - Add power monitor device INA220 for ls208xa-rdb board.

----------------------------------------------------------------
Ashish Kumar (1):
      arm64: dts: ls1088a: Added dcfg node in ls1088a dtsi

Ioana Ciornei (1):
      arm64: dts: ls1088a: add fsl-mc hardware resource manager node

Yuantian Tang (1):
      arm64: dts: ls208xa: add power monitor chip node

yinbo.zhu (1):
      arm64: dts: ls1088a: Add USB support

 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |  8 ++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 97 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 12 +++
 3 files changed, 117 insertions(+)
