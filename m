From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Jan 2012 12:58:59 +0100
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20120126115859.GI5446@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX fixes for -rc.

Sascha

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes

Fabio Estevam (1):
      ARM: imx: iomux-v1.h: Fix build error due to __init annotation

Julia Lawall (1):
      arch/arm/mach-imx/mach-mx53_ard.c: add missing iounmap

 arch/arm/mach-mx5/board-mx53_ard.c        |    4 +++-
 arch/arm/plat-mxc/include/mach/iomux-v1.h |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
