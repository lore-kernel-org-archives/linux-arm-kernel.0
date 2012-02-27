From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Feb 2012 10:33:54 +0100
Subject: [GIT PULL] i.MX fixes
Message-ID: <20120227093354.GY3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd,

Please pull the following for -rc. Note that this partly replaces the
previous i.MX branch you pulled as suggested.

Sascha

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes

for you to fetch changes up to 9418ba306688c0b77a8548b3281ba3d130036516:

  ARM: mach-imx: mx3: Fix section mismatch in imx3_init_l2x0() (2012-02-27 10:15:27 +0100)

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: mach-pcm038: Fix field name of regulator_consumer_supply struct
      ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash support for iMX21ADS board
      ARM: mach-imx: mx3: Fix section mismatch in imx3_init_l2x0()

 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 arch/arm/mach-imx/mach-pcm038.c      |    2 +-
 arch/arm/mach-imx/mm-imx3.c          |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
