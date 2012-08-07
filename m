From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 7 Aug 2012 09:17:52 +0200
Subject: [GIT PULL] i.MX fixes for 3.6-rc
Message-ID: <20120807071752.GG1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX fixes for 3.6-rc

Sascha

The following changes since commit 1a9b4993b70fb1884716902774dc9025b457760d:

  Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus (2012-08-01 16:47:15 -0700)

are available in the git repository at:


  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes

for you to fetch changes up to 9de76b6df70003b657d907571b17ac3c17cd9082:

  i.MX27: Fix emma-prp and csi clocks. (2012-08-07 09:14:30 +0200)

----------------------------------------------------------------
ARM i.MX fixes for 3.6-rc

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: dts: imx27-3ds.dts: Fix serial console node
      ARM: clk-imx31: Fix the keypad clock name

Javier Martin (1):
      i.MX27: Fix emma-prp and csi clocks.

 arch/arm/boot/dts/imx27-3ds.dts |    2 +-
 arch/arm/mach-imx/clk-imx27.c   |    8 +++++---
 arch/arm/mach-imx/clk-imx31.c   |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
