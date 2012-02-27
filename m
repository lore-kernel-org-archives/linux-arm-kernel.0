From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Feb 2012 10:35:59 +0100
Subject: [GIT PULL] i.MX driver patches
Message-ID: <20120227093559.GA3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following for -next. Note that this partly replaces the
previous i.MX branch you pulled as suggested.

Sascha


The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx-drivers

for you to fetch changes up to 15cc1b1c1e8848ffa711f4ea24c919627a1159da:

  ARM: imx_v4_v5_defconfig: Update defconfig (2012-02-27 10:14:15 +0100)

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Add support for framebuffer and camera on mx31
      ARM: mx27_3ds: Add camera support
      ARM: imx_v4_v5_defconfig: Update defconfig

 arch/arm/configs/imx_v4_v5_defconfig |   16 +++++
 arch/arm/configs/imx_v6_v7_defconfig |   32 ++++++++++
 arch/arm/mach-imx/Kconfig            |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c    |  108 ++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 0 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
