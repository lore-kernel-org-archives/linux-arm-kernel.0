From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 29 Apr 2010 09:14:58 +0200
Subject: MXC Pull request for -rc
Message-ID: <20100429071458.GL7634@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following for -rc. Only a single patch which prevents
mx51_defconfig from building.

Sascha

The following changes since commit 2ba3abd8186f24c7fb418927025b4e2120e3a362:
  Linus Torvalds (1):
        Merge branch 'pm-fixes' of git://git.kernel.org/.../rafael/suspend-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Dinh Nguyen (1):
      mx5: Fix build error for mx51_defconfig

 arch/arm/mach-mx5/clock-mx51.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
