From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2011 11:40:43 +0100
Subject: [GIT PULL] i.MXf fixes/cleanups
Message-ID: <20111122104043.GG27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following for -rc. It contains build fixes and also
some cleanups.

Sascha

The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:

  Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-arnd

Arnd Bergmann (1):
      ARM: imx: export imx_ioremap

Fabio Estevam (2):
      ARM: imx: Remove unused chip revision strings
      ARM: mx5: Fix checkpatch warnings in cpu-imx5.c

Paul Bolle (1):
      ARM: imx: drop 'ARCH_MX31' and 'ARCH_MX35'

Sascha Hauer (4):
      MAINTAINERS: Add missing directory
      Merge branches 'fixes/imx3-build', 'fixes/imx_ioremap' and 'fixes/maintainer-update' into imx-fixes
      Merge branch 'cleanups/assorted' into imx-fixes-for-arnd
      Merge branch 'cleanups/remove-unused-kconfig' into imx-fixes-for-arnd

Shawn Guo (1):
      arm/imx: remove imx_idle hook and use pm_idle instead

Uwe Kleine-K?nig (1):
      ARM: imx/mm-imx3: conditionally compile i.MX31 and i.MX35 code

 MAINTAINERS                             |    1 +
 arch/arm/mach-imx/Kconfig               |   13 ----
 arch/arm/mach-imx/mm-imx3.c             |  109 ++++++++++++++++--------------
 arch/arm/mach-mx5/cpu.c                 |    5 +-
 arch/arm/mach-mx5/mm.c                  |    6 +-
 arch/arm/plat-mxc/include/mach/common.h |    1 -
 arch/arm/plat-mxc/include/mach/mxc.h    |   14 ----
 arch/arm/plat-mxc/include/mach/system.h |    7 +--
 arch/arm/plat-mxc/system.c              |    3 +-
 9 files changed, 69 insertions(+), 90 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
