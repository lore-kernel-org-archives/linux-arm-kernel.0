From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Mar 2015 22:02:59 +0800
Subject: [GIT PULL 4/4] ARM: imx: defconfig updates for 4.1
Message-ID: <CAAQ0ZWQPckdOfC_HyP8s4pp66Nx_QbsLBFEmF=d2d6vTY-59Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
tags/imx-defconfig-4.1

for you to fetch changes up to bfc6dc138ef01a65365834dcf251b95ace9969b7:

  ARM: imx_v6_v7_defconfig: Enable Bluetooth support (2015-03-16 16:11:23 +0800)

----------------------------------------------------------------
The i.MX defconfig updates for 4.1:
 - Enable VFAT, Bluetooth and PCA953X GPIO expander support

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: mxs_defconfig: Add VFAT support
      ARM: imx_v4_v5_defconfig: Add VFAT support
      ARM: imx_v6_v7_defconfig: Enable Bluetooth support

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: Add CONFIG_GPIO_PCA953X

 arch/arm/configs/imx_v4_v5_defconfig | 1 +
 arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
 arch/arm/configs/mxs_defconfig       | 1 +
 3 files changed, 6 insertions(+)
