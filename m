From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 21 Jul 2018 10:37:50 +0800
Subject: [GIT PULL 5/6] Freescale arm64 device tree updates for 4.19
In-Reply-To: <1532140671-2869-1-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
 <1532140671-2869-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1532140671-2869-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.19

for you to fetch changes up to 346f5976cc3200896d5fb873412a4fe9c0fc611e:

  arm64: dts: freescale: Add missing cooling device properties for CPUs (2018-07-03 15:01:09 +0800)

----------------------------------------------------------------
Freescale arm64 device tree update for 4.19:
 - Update device tree sources to use SPDX identifiers for license.
 - Add cooling device property '#cooling-cells' for all CPUs of
   a cluster.

----------------------------------------------------------------
Li Yang (1):
      arm64: dts: freescale: Update to use SPDX identifiers

Viresh Kumar (1):
      arm64: dts: freescale: Add missing cooling device properties for CPUs

 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi |  3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 39 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 39 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 44 +++-------------------
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 39 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 39 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 42 ++-------------------
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 44 ++++------------------
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 42 +++------------------
 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts  | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     | 42 +++------------------
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 38 +------------------
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     | 38 +------------------
 .../boot/dts/freescale/qoriq-bman-portals.dtsi     |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |  2 +-
 .../boot/dts/freescale/qoriq-qman-portals.dtsi     |  2 +-
 36 files changed, 57 insertions(+), 872 deletions(-)
