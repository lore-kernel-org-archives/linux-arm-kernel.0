From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Oct 2011 11:23:44 +0200
Subject: [GIT PULL] assorted i.MX fixes
Message-ID: <20111025092344.GU23421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following assorted i.MX fixes. Should have send this
earlier, I promise to do this next time.

Sascha

The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes-for-arnd

Arnaud Patard (1):
      MX5: fix clock usage

Fabio Estevam (1):
      ARM: mx31pdk: Fix build by passing IMX_HAVE_PLATFORM_MXC_MMC

Matt Burtch (1):
      ARM: i.MX28: shift frac value in _CLK_SET_RATE

Paul Bolle (1):
      ARM: imx: Fix typo 'MACH_MX31_3DS_MXC_NAND_USE_BBT'

Paul Fertser (1):
      plat-mxc: iomux-v3.h: implicitly enable pull-up/down when that's desired

 arch/arm/mach-imx/Kconfig                 |    1 +
 arch/arm/mach-imx/mach-mx31_3ds.c         |    2 +-
 arch/arm/mach-mx5/pm-imx5.c               |   15 ++++++++++++---
 arch/arm/mach-mxs/clock-mx28.c            |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-v3.h |   10 +++++-----
 5 files changed, 20 insertions(+), 10 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
