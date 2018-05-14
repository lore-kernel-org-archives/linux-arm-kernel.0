From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 May 2018 14:33:36 +0800
Subject: [GIT PULL] i.MX fixes for 4.17
Message-ID: <20180514063335.GI26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.17

for you to fetch changes up to 6d3299aef7df7225ecff653feedafb5d1646998b:

  ARM: dts: imx51-zii-rdu1: fix touchscreen bindings (2018-05-11 13:50:27 +0800)

----------------------------------------------------------------
i.MX fixes for 4.17:
 - Add missing 'fsl,sec-era' property for i.MX7S device tree CAAM node,
   as the era information is used in various places inside CAAM driver.
 - There are a few errors in imx51-zii-rdu1 device tree touchscreen
   node.  Fix them to get touchscreen actually work.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx7s: Pass the 'fsl,sec-era' property

Nikita Yushchenko (1):
      ARM: dts: imx51-zii-rdu1: fix touchscreen bindings

 arch/arm/boot/dts/imx51-zii-rdu1.dts | 6 +++---
 arch/arm/boot/dts/imx7s.dtsi         | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)
