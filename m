From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Jul 2011 09:52:58 +0200
Subject: GIT PULL: i.MX fixes for -rc
Message-ID: <20110704075258.GC6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the following patches for -rc. It contains some fixes
for section mismatches and some board specific fixes.

Sascha


The following changes since commit 56299378726d5f2ba8d3c8cbbd13cb280ba45e4f:

  Linux 3.0-rc4 (2011-06-20 20:25:46 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Arnaud Patard (3):
      efikasb/mx: fix usbh1 initialisation
      efikasb: fix gpio keys.
      efika: Fix board id detection

Eric Miao (1):
      ARM: mx53: add pad configuration for I2C signals

Fabio Estevam (2):
      ARM: mach-imx/mx31ads: Fix section mismatches
      ARM: mach-imx/mx31lilly: Fix section mismatches

Javier Martin (1):
      Add tlv320aic32x4 platform data to Visstrim_M10.

Troy Kisky (1):
      ARM: mxc: Fix gpio interrupts for mx53

 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   13 +++++++++++
 arch/arm/mach-imx/mach-mx31ads.c            |    4 +-
 arch/arm/mach-imx/mach-mx31lilly.c          |    2 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c      |    6 ++--
 arch/arm/mach-mx5/board-mx51_efikasb.c      |   15 +++++++------
 arch/arm/mach-mx5/mx51_efika.c              |    2 +-
 arch/arm/plat-mxc/gpio.c                    |    3 +-
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |   31 ++++++++++++++------------
 8 files changed, 47 insertions(+), 29 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
