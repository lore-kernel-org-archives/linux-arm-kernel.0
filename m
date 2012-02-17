From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 17 Feb 2012 09:24:26 +0100
Subject: [GIT PULL] i.MX assorted
Message-ID: <20120217082426.GO3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Please pull the following assorted updates for i.MX.

Sascha


The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git features/assorted

for you to fetch changes up to bc17b36704e051ec67eeaa6e10d7e20ce32c76cf:

  ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash support for iMX21ADS board (2012-02-17 09:20:31 +0100)

----------------------------------------------------------------
Fabio Estevam (7):
      ARM: mach-pcm038: Fix field name of regulator_consumer_supply struct
      ARM: imx_v6_v7_defconfig: Add support for framebuffer and camera on mx31
      ARM: mx27_3ds: Add camera support
      ARM: imx_v4_v5_defconfig: Update defconfig
      ARM: plat-mxc: audmux-v1: Remove unneeded ifdef's
      ARM: mx3: Let mx31 and mx35 share the same CCM header file
      ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash support for iMX21ADS board

 arch/arm/configs/imx_v4_v5_defconfig               |   17 ++
 arch/arm/configs/imx_v6_v7_defconfig               |   32 ++++
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/clock-imx31.c                    |    2 +-
 arch/arm/mach-imx/clock-imx35.c                    |  166 +++++++++-----------
 .../mach-imx/{crmregs-imx31.h => crmregs-imx3.h}   |   15 ++-
 arch/arm/mach-imx/mach-armadillo5x0.c              |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |  108 +++++++++++++
 arch/arm/mach-imx/mach-pcm038.c                    |    2 +-
 arch/arm/plat-mxc/audmux-v1.c                      |    5 +-
 10 files changed, 251 insertions(+), 99 deletions(-)
 rename arch/arm/mach-imx/{crmregs-imx31.h => crmregs-imx3.h} (94%)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
