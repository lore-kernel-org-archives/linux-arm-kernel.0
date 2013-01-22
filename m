From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Jan 2013 09:16:57 +0100
Subject: [GIT PULL] i.MX fixes for -rc
Message-ID: <20130122081656.GI1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following fix for -rc.

Sascha

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes-rc

for you to fetch changes up to e909c682d04e55e77a3c9d158e7dc36027195493:

  [media] coda: Fix build due to iram.h rename (2013-01-08 09:44:06 +0100)

----------------------------------------------------------------
ARM i.MX fixes for -rc.

This contains a single compilation fix for the CODA driver.

----------------------------------------------------------------
Sascha Hauer (1):
      [media] coda: Fix build due to iram.h rename

 arch/arm/mach-imx/iram_alloc.c                                     |    3 +--
 drivers/media/platform/coda.c                                      |    2 +-
 arch/arm/mach-imx/iram.h => include/linux/platform_data/imx-iram.h |    0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/mach-imx/iram.h => include/linux/platform_data/imx-iram.h (100%)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
