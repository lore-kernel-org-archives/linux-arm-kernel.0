From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 Nov 2011 16:57:21 +0100
Subject: [GIT PULL] i.MX fixes
Message-ID: <20111111155721.GB16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following. I don't know exactly when Arnd is back again,
so I have Olof still on Cc.

Sascha

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes-for-arnd

Richard Zhao (1):
      ARM: mx51/53: set pwm clock parent to ipg_perclk

Shawn Guo (3):
      arm/imx: fix the references to ARCH_MX3
      arm/imx: fix AUTO_ZRELADDR selection
      arm/imx: fix imx6q mmc error when mounting rootfs

 arch/arm/mach-imx/Makefile.boot     |   34 +++++++++++++++++++---------------
 arch/arm/mach-imx/clock-imx6q.c     |   17 ++++++++++++++++-
 arch/arm/mach-mx5/clock-mx51-mx53.c |    4 ++--
 arch/arm/plat-mxc/Kconfig           |    4 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c  |    8 ++++++++
 5 files changed, 47 insertions(+), 20 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
