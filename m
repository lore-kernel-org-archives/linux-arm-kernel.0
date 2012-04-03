From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 3 Apr 2012 09:02:25 +0200
Subject: [GIT PULL] i.MX fixes for rc2
Message-ID: <20120403070225.GG3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX fixes for -rc2

Sascha

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/v3.4-rc1-imx-fixes

for you to fetch changes up to 7a4302a6a123e09b26fd7eae387e88e2d4dbc8c4:

  ARM: armadillo5x0: Fix smsc911x driver probe (2012-04-02 16:31:22 +0200)

----------------------------------------------------------------
Linux-3.4-rc1 i.MX fixes

----------------------------------------------------------------
Fabio Estevam (8):
      ARM: mach-mx35_3ds: Fix build warning due to the lack of 'const' annotation
      ARM: 3ds_debugboard: Fix smsc911x driver probe
      ARM: mx35: Fix registration of camera clock
      ARM: mx53ard: Fix smsc911x driver probe
      ARM: mx31lite: Fix smsc911x driver probe
      ARM: mx31lilly: Fix smsc911x driver probe
      ARM: kzm_arm11_01: Fix smsc911x driver probe
      ARM: armadillo5x0: Fix smsc911x driver probe

Javier Martin (1):
      MX2: Fix mx2_camera clock regression.

 arch/arm/mach-imx/clock-imx27.c       |    1 +
 arch/arm/mach-imx/clock-imx35.c       |    2 +-
 arch/arm/mach-imx/mach-armadillo5x0.c |    9 +++++++++
 arch/arm/mach-imx/mach-kzm_arm11_01.c |    9 +++++++++
 arch/arm/mach-imx/mach-mx31lilly.c    |    9 +++++++++
 arch/arm/mach-imx/mach-mx31lite.c     |    9 +++++++++
 arch/arm/mach-imx/mach-mx35_3ds.c     |    2 +-
 arch/arm/mach-imx/mach-mx53_ard.c     |    8 ++++++++
 arch/arm/plat-mxc/3ds_debugboard.c    |    2 +-
 9 files changed, 48 insertions(+), 3 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
