From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jun 2012 22:04:51 +0200
Subject: [GIT PULL] i.MX fixes
Message-ID: <20120607200451.GQ30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please pull the following i.MX fixes for -rc.

Sascha

The following changes since commit 76e10d158efb6d4516018846f60c2ab5501900bc:

  Linux 3.4 (2012-05-20 15:29:13 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx/fixes

for you to fetch changes up to 350ab15bb2ffe7103bc6bf6c634f3c5b286eaf2a:

  ARM i.MX imx21ads: Fix overlapping static i/o mappings (2012-06-07 21:34:22 +0200)

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: mx31_3ds: Fix build due to missing IMX_HAVE_PLATFORM_IMX_SSI

Jaccon Bastiaansen (1):
      ARM i.MX imx21ads: Fix overlapping static i/o mappings

Javier Martin (1):
      ARM i.MX27 Visstrim M10: fix gpio handling.

Uwe Kleine-K?nig (2):
      ARM: imx: only specify i2c device type once
      ARM: imx: only call l2x0_init if it's available

 arch/arm/mach-imx/Kconfig                   |    1 +
 arch/arm/mach-imx/mach-cpuimx35.c           |    1 -
 arch/arm/mach-imx/mach-cpuimx51sd.c         |    1 -
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   36 +++++++++++++++++++--------
 arch/arm/mach-imx/mach-mx21ads.c            |    2 +-
 arch/arm/mach-imx/mm-imx3.c                 |    2 ++
 6 files changed, 29 insertions(+), 14 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
