From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 May 2012 10:32:35 +0200
Subject: [GIT PULL] i.MX cleanups for 3.5
Message-ID: <20120502083235.GU4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Olof,

Please pull the following i.MX cleanup patches for 3.5. The iomux
patches could be fixes, but the changed pads are currently unused in
mainline, so I included them here.

Sascha

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-cleanup

for you to fetch changes up to 6838e601e6dc63440fd4315c1c2f3a2ef4ccdd6e:

  ARM: mx53: fix pad definitions for MX53_PAD_EIM_D28__I2C1_SDA and MX53_PAD_GPIO_8__CAN1_RXCAN (2012-05-02 10:28:36 +0200)

----------------------------------------------------------------
ARM: i.MX cleanups for 3.5

----------------------------------------------------------------
Alexander Shiyan (1):
      ARM: i.MX51 iomux: add missed definitions for SION-bit and mode for some pads

Lothar Wa?mann (1):
      ARM: mx53: fix pad definitions for MX53_PAD_EIM_D28__I2C1_SDA and MX53_PAD_GPIO_8__CAN1_RXCAN

Marc Kleine-Budde (2):
      arm: imx: make various struct sys_timer static
      arm: imx: add missing select IMX_HAVE_PLATFORM for MACH_MX35_3DS in Kconfig

Uwe Kleine-K?nig (1):
      ARM: imx/eukrea_mbimx27-baseboard: fix typo in error message

 arch/arm/mach-imx/Kconfig                    |    2 ++
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    2 +-
 arch/arm/mach-imx/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c              |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c            |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c         |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-pcm037.c              |    2 +-
 arch/arm/mach-imx/mach-pcm043.c              |    2 +-
 arch/arm/mach-imx/mach-vpr200.c              |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h  |   48 +++++++++++++-------------
 arch/arm/plat-mxc/include/mach/iomux-mx53.h  |    4 +--
 12 files changed, 37 insertions(+), 35 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
