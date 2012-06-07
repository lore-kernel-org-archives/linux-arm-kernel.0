From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jun 2012 22:02:09 +0200
Subject: [GIT PULL] more i.MX clock fixes
Message-ID: <20120607200209.GP30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Please pull the following i.MX clock fixes for -rc.

Sascha

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx/clk-fixes

for you to fetch changes up to cdd781ab1906d039c2a93078385645d2d5af8491:

  ARM i.MX53: Fix PLL4 base address (2012-06-04 15:23:57 +0200)

----------------------------------------------------------------
Sascha Hauer (3):
      ARM i.MX pllv2: use standard register set unconditionally
      ARM i.MX pllv2: make round_rate accurate
      ARM i.MX53: Fix PLL4 base address

 arch/arm/mach-imx/clk-pllv2.c     |   93 ++++++++++++++++++++++---------------
 arch/arm/mach-imx/crm-regs-imx5.h |    2 +-
 2 files changed, 56 insertions(+), 39 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
