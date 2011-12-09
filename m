From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Dec 2011 11:09:26 +0100
Subject: [GIT PULL] i.MX fixes
Message-ID: <20111209100926.GD27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following small fixes.

Sascha

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes-for-arnd

Dong Aisheng (1):
      ARM: mx5: add __initconst for fec pdata

Jason Chen (1):
      MXC PWM: should active during DOZE/WAIT/DBG mode

Richard Zhao (1):
      ARM: imx: fix cpufreq build errors

 arch/arm/mach-mx5/board-mx53_evk.c  |    2 +-
 arch/arm/mach-mx5/board-mx53_loco.c |    2 +-
 arch/arm/mach-mx5/board-mx53_smd.c  |    2 +-
 arch/arm/plat-mxc/cpufreq.c         |    1 +
 arch/arm/plat-mxc/pwm.c             |    7 ++++++-
 5 files changed, 10 insertions(+), 4 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
