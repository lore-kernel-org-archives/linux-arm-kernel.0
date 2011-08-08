From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Aug 2011 08:35:49 +0200
Subject: [GIT PULL] imx-fixes
Message-ID: <20110808063549.GL31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd,

Please pull the following fixes for i.MX.

Sascha

PS: The branch is not based on -rc1, I just had to merge it in to apply
the patch from Ben Dooks.

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-fixes-for-arnd

Arnaud Patard (3):
      efikasb/mx: fix usbh1 initialisation
      efikasb: fix gpio keys.
      efika: Fix board id detection

Ben Dooks (1):
      ARM: mx5: board-cpuimx51.c fixup irq_to_gpio() usage

Eric Miao (1):
      ARM: mx53: add pad configuration for I2C signals

Fabio Estevam (3):
      ARM: mach-imx/mx31ads: Fix section mismatches
      ARM: mach-imx/mx31lilly: Fix section mismatches
      ARM: board-mx51_babbage: Fix UART2 registration

Jason Liu (1):
      ARM: iMX5: Don't enable DPLL if it already enabled

Javier Martin (1):
      Add tlv320aic32x4 platform data to Visstrim_M10.

Mehnert, Torsten (1):
      i.MX25 GPT clock fix: ensure correct the clock source

Sascha Hauer (1):
      Merge commit 'v3.1-rc1' into imx-fixes

 arch/arm/mach-imx/clock-imx25.c             |    3 ++
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   13 +++++++++++
 arch/arm/mach-imx/mach-mx31ads.c            |    4 +-
 arch/arm/mach-imx/mach-mx31lilly.c          |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c          |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c      |    2 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c      |    6 ++--
 arch/arm/mach-mx5/board-mx51_efikasb.c      |   15 +++++++------
 arch/arm/mach-mx5/clock-mx51-mx53.c         |    6 ++++-
 arch/arm/mach-mx5/mx51_efika.c              |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |   31 ++++++++++++++------------
 11 files changed, 55 insertions(+), 31 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
