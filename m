From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 15:53:39 +0800
Subject: [GIT PULL 2/3] Freescale arm64 device tree updates for 4.14
In-Reply-To: <1503042820-13043-1-git-send-email-shawnguo@kernel.org>
References: <1503042820-13043-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1503042820-13043-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.14

for you to fetch changes up to f83de4f0088f396b63d1cf1f013a003f3f094b1b:

  arm64: dts: ls1088: Correction in Board name from "L1088A" to "LS1088A" (2017-08-14 09:39:45 +0800)

----------------------------------------------------------------
Freescale arm64 device tree updates for 4.14:
 - Correct the typo in fsl-ls1088a-rdb board name.
 - A series from Horia Geant? to consolidate aliases node and enable
   crypto support for ls208xa and ls1088a.
 - Enable USB host support for ls1012a.
 - Enable cpuidle support for ls1088a and ls208xa.

----------------------------------------------------------------
Ashish Kumar (1):
      arm64: dts: ls1088: Correction in Board name from "L1088A" to "LS1088A"

Horia Geant? (3):
      arm64: dts: freescale: ls208xa: share aliases node
      arm64: dts: freescale: ls208xa: add crypto node
      arm64: dts: freescale: ls1088a: add crypto node

Ran Wang (1):
      arm64: dts: ls1012a: add USB host controller nodes

Yuantian Tang (2):
      arm64: dts: ls1088a: add cpu idle support
      arm64: dts: ls208xa: add cpu idle support

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 17 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 65 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |  5 --
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |  5 --
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |  5 --
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 17 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts  |  5 --
 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts  |  5 --
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     | 17 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     | 51 +++++++++++++++++
 11 files changed, 168 insertions(+), 26 deletions(-)
