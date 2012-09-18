From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 18 Sep 2012 16:49:19 +0200
Subject: [GIT PULL] i.MX fixes for 3.6
Message-ID: <20120918144919.GT6180@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Olof,

Please pull the following i.MX fixes for 3.6.

Thanks
 Sascha

The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes

for you to fetch changes up to 42a3f891caee0d9baa60a6964e41a28b9c657407:

  ARM i.MX25: Make timer irq work again (2012-09-18 16:46:50 +0200)

----------------------------------------------------------------
ARM i.MX: Two fixes for i.MX

- armadillo5x0 board broken since v3.5 (stable material)
- i.MX25 Architecture broken since v3.6-rc1

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx: armadillo5x0: Fix illegal register access

Sascha Hauer (1):
      ARM i.MX25: Make timer irq work again

 arch/arm/mach-imx/clk-imx25.c         |    2 +-
 arch/arm/mach-imx/mach-armadillo5x0.c |    3 ++-
 arch/arm/plat-mxc/include/mach/mx25.h |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
