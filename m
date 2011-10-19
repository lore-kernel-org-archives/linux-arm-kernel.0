From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Oct 2011 09:07:58 +0200
Subject: [GIT PULL] i.MX cleanup patches
Message-ID: <20111019070758.GA18759@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[again with list on cc]

Please pull the following i.MX cleanup patches.

Sascha

The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-cleanups-for-arnd

Lauri Hintsala (1):
      ARM: mach-mxs: fix machines' initializers order

Sascha Hauer (1):
      Merge branches 'cleanups/mxs', 'cleanups/mx3-defconfig' and 'cleanups/includes' into imx-cleanups-for-arnd

Shawn Guo (5):
      arm/imx: remove mx31_setup_weimcs() from mx31.h
      arm/imx: explicitly includes mach/hardware.h in mach-kzm_arm11_01.c
      arm/imx: remove mx27_setup_weimcs() from mx27.h
      arm/imx: explicitly includes mach/hardware.h in pm-imx27.c
      mmc: mxcmmc: explicitly includes mach/hardware.h

Wolfram Sang (1):
      arm: mx3: update defconfig

 arch/arm/configs/mx3_defconfig        |   46 +++++++++++++++++++++++---------
 arch/arm/mach-imx/mach-kzm_arm11_01.c |    1 +
 arch/arm/mach-imx/mach-pcm038.c       |    4 ++-
 arch/arm/mach-imx/mach-qong.c         |    5 +++-
 arch/arm/mach-imx/pm-imx27.c          |    2 +-
 arch/arm/mach-mxs/mach-mx23evk.c      |    2 +-
 arch/arm/mach-mxs/mach-mx28evk.c      |    2 +-
 arch/arm/mach-mxs/mach-tx28.c         |    2 +-
 arch/arm/plat-mxc/include/mach/mx27.h |   14 ----------
 arch/arm/plat-mxc/include/mach/mx31.h |   14 ----------
 drivers/mmc/host/mxcmmc.c             |    1 +
 11 files changed, 46 insertions(+), 47 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
