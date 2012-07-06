From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Jul 2012 08:45:38 +0200
Subject: [GIT PULL] i.MX cleanups for 3.6
Message-ID: <20120706064538.GB30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please pull the following i.MX cleanups for 3.6

Sascha

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-cleanup

for you to fetch changes up to bec31a85f0f83567ed4b77e0cd6399bac2f0f037:

  ARM: imx: remove unused pdata from device macros (2012-07-06 08:25:20 +0200)

----------------------------------------------------------------
ARM i.MX cleanups for v3.6

----------------------------------------------------------------
Beno?t Th?baudeau (2):
      ARM: imx: cleanup otg_mode
      ARM: imx: remove unused pdata from device macros

Fabio Estevam (1):
      ARM: imx: Kconfig: Remove IMX_HAVE_PLATFORM_IMX_SSI from MACH_MX25_3DS

Uwe Kleine-K?nig (1):
      ARM: imx27/dt: make dt_compat entry const

 arch/arm/mach-imx/Kconfig                |    1 -
 arch/arm/mach-imx/devices-imx21.h        |    4 ++--
 arch/arm/mach-imx/devices-imx25.h        |    4 ++--
 arch/arm/mach-imx/devices-imx27.h        |    6 +++---
 arch/arm/mach-imx/devices-imx31.h        |    6 +++---
 arch/arm/mach-imx/devices-imx35.h        |    4 ++--
 arch/arm/mach-imx/devices-imx51.h        |    2 +-
 arch/arm/mach-imx/devices-imx53.h        |    2 +-
 arch/arm/mach-imx/imx27-dt.c             |    2 +-
 arch/arm/mach-imx/mach-cpuimx27.c        |   12 ++++++------
 arch/arm/mach-imx/mach-cpuimx35.c        |   10 +++++-----
 arch/arm/mach-imx/mach-cpuimx51sd.c      |   10 +++++-----
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c |   12 ++++++------
 arch/arm/mach-imx/mach-imx27ipcam.c      |    2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c        |    4 ++--
 arch/arm/mach-imx/mach-mx27_3ds.c        |   10 +++++-----
 arch/arm/mach-imx/mach-mx27ads.c         |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c        |   10 +++++-----
 arch/arm/mach-imx/mach-mx31moboard.c     |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c        |   10 +++++-----
 arch/arm/mach-imx/mach-mx51_3ds.c        |    2 +-
 arch/arm/mach-imx/mach-mx51_babbage.c    |   10 +++++-----
 arch/arm/mach-imx/mach-mx53_ard.c        |    2 +-
 arch/arm/mach-imx/mach-mx53_evk.c        |    2 +-
 arch/arm/mach-imx/mach-mx53_loco.c       |    2 +-
 arch/arm/mach-imx/mach-mx53_smd.c        |    2 +-
 arch/arm/mach-imx/mach-pca100.c          |   12 ++++++------
 arch/arm/mach-imx/mach-pcm037.c          |   12 ++++++------
 arch/arm/mach-imx/mach-pcm038.c          |    4 ++--
 arch/arm/mach-imx/mach-pcm043.c          |   10 +++++-----
 arch/arm/mach-imx/mach-qong.c            |    2 +-
 arch/arm/mach-imx/mach-vpr200.c          |    2 +-
 arch/arm/mach-imx/mx31lite-db.c          |    4 ++--
 33 files changed, 90 insertions(+), 91 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
