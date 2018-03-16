From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Mar 2018 10:28:55 +0800
Subject: [GIT PULL] i.MX device tree updates for 4.17, round 2
Message-ID: <20180316022854.GR26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f4be9b77fac3d8141add1d84e75199f0e0ddd5a3:

  ARM: dts: i.MX25: define SSI FIFO depth (2018-03-12 15:23:36 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.17-2

for you to fetch changes up to 326e7ba992cbe17c12d4235f65d72c6e222a73a1:

  ARM: dts: imx6ul-isiot: Pass the required '#sound-dai-cells' (2018-03-16 09:13:38 +0800)

----------------------------------------------------------------
i.MX device tree updates for 4.17, round 2:
 - Add missing property '#sound-dai-cells' for sgtl5000 codec node
   in imx6ul-isiot board to fix warning seen with DTC 1.4.6.
 - Use stdout-path instead of linux,stdout-path to fix DTC warning
   reported by DTC 1.4.6.

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: dts: imx6-phytec: Use the standard 'stdout-path' property
      ARM: dts: imx6ul-isiot: Pass the required '#sound-dai-cells'

 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts | 2 +-
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts  | 2 +-
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts  | 2 +-
 arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts | 2 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi               | 1 +
 5 files changed, 5 insertions(+), 4 deletions(-)
