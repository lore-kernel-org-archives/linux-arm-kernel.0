From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 12:17:46 +0200
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20120418101746.GS3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please pull the following for -rc.

Thanks
 Sascha


The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/v3.4-rc3-imx-fixes

for you to fetch changes up to 4659b7f1fa3eb33a8f9a9dd209a5823602dc6dcf:

  ARM: imx: Fix imx5 idle logic bug (2012-04-18 11:52:24 +0200)

----------------------------------------------------------------
ARM i.MX misc fixes for -rc

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx_v4_v5_defconfig: Add support for CONFIG_REGULATOR_FIXED_VOLTAGE
      ARM: imx27-dt: Fix build due to removal of irq_domain_add_simple()

Robert Lee (1):
      ARM: imx: Fix imx5 idle logic bug

 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 arch/arm/mach-imx/imx27-dt.c         |    6 ++++--
 arch/arm/mach-imx/mm-imx5.c          |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
