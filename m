From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 4 Jul 2012 09:43:38 +0200
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20120704074338.GN2698@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX fixes for -rc

Thanks
 Sascha


The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/v3.5-imx-fixes

for you to fetch changes up to c520c921eacdced7e2095ba6cbbb9921906c7b67:

  ARM: imx: assert SCC gate stays enabled (2012-07-04 09:38:29 +0200)

----------------------------------------------------------------
ARM i.MX fixes for v3.5-rc5

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx27_visstrim_m10: Do not include <asm/system.h>

Uwe Kleine-K?nig (1):
      ARM: imx: assert SCC gate stays enabled

 arch/arm/mach-imx/clk-imx35.c               |    9 ++++++++-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
