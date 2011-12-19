From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Dec 2011 12:29:15 +0100
Subject: [GIT PULL]
Message-ID: <20111219112915.GN27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following for -rc. Most stuff is regressions since
the last merge window, so only "ARM:imx:fix pwm period value" has
Cc stable.

Sascha

The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:

  Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git fixes-for-arnd

Eric B?nard (7):
      cpuimx25sd: fix Kconfig
      imx_v4_v5_defconfig: update default configuration
      dma: MX3_IPU fix depends
      clock-imx35: fix reboot in internal boot mode
      cpuimx35sd: fix Kconfig
      cpuimx35: fix touchscreen support
      enable uncompress log on cpuimx35sd

Jason Chen (1):
      ARM:imx:fix pwm period value

Richard Zhao (1):
      arm/imx: fix cpufreq section mismatch

 arch/arm/configs/imx_v4_v5_defconfig        |   12 +++++++-----
 arch/arm/mach-imx/Kconfig                   |    8 ++++----
 arch/arm/mach-imx/Makefile                  |    4 ++--
 arch/arm/mach-imx/clock-imx35.c             |   20 ++++++++++----------
 arch/arm/mach-imx/mach-cpuimx35.c           |    8 +++++++-
 arch/arm/plat-mxc/cpufreq.c                 |    2 +-
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 arch/arm/plat-mxc/pwm.c                     |    9 +++++++++
 drivers/dma/Kconfig                         |    4 ++--
 9 files changed, 43 insertions(+), 25 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
