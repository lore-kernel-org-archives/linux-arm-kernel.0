From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Oct 2012 09:56:56 +0200
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20121024075656.GW27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following, mostly clock related, i.MX fixes for -rc.

Thanks
 Sascha

The following changes since commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9:

  Linux 3.6 (2012-09-30 16:47:46 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes

for you to fetch changes up to 92063cee118655d25b50d04eb77b012f3287357a:

  ARM i.MX25: Fix PWM per clock lookups (2012-10-10 10:02:42 +0200)

----------------------------------------------------------------
ARM i.MX fixes for 3.7-rc

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Enable CONFIG_GPIO_MC9S08DZ60
      ARM: imx: clk-imx27: Fix divider width field
      ARM: mxc: platform-mxc-mmc: Fix register region size

Sascha Hauer (3):
      ARM i.MX25: Fix lcdc_ipg_per parent clock
      ARM i.MX25 clk: Fix nfc_ipg_per parent
      ARM i.MX25: Fix PWM per clock lookups

Wei Yongjun (2):
      ARM: imx: fix return value check in imx3_init_l2x0()
      ARM: imx: fix the return value check in imx_clk_busy_divider()

 arch/arm/configs/imx_v6_v7_defconfig         |    2 ++
 arch/arm/mach-imx/clk-busy.c                 |    2 +-
 arch/arm/mach-imx/clk-imx25.c                |   12 ++++++------
 arch/arm/mach-imx/clk-imx27.c                |    4 ++--
 arch/arm/mach-imx/mm-imx3.c                  |    5 ++---
 arch/arm/plat-mxc/devices/platform-mxc-mmc.c |    2 +-
 6 files changed, 14 insertions(+), 13 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
