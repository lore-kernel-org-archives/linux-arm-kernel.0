From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 22:17:16 +0800
Subject: [GIT PULL] imx fixes for 3.9, take 2
Message-ID: <20130311141714.GD25910@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0545c798e9bb7fe29606681653c20d68e47f4840:

  ARM: dts: imx53-mba53: fix fsl,pins for disp1-grp1 (2013-03-04 09:20:15 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.9-2

for you to fetch changes up to 0c52db7e681678f9b2a3fb96c3dd557168b4e025:

  ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART" (2013-03-11 21:28:18 +0800)

----------------------------------------------------------------
The 2nd take of imx fixes for 3.9:
 - Fix pll1_sys clk initial status
 - Fix a typo in imx DEBUG_LL Kconfig

----------------------------------------------------------------
Paul Bolle (1):
      ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"

Shawn Guo (1):
      ARM: imx: pll1_sys should be an initial on clk

 arch/arm/Kconfig.debug        |    2 +-
 arch/arm/mach-imx/clk-imx6q.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
