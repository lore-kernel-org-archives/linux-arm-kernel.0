From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Apr 2011 10:19:24 +0200
Subject: [GIT PULL] i.MX for -rc
Message-ID: <20110420081924.GB14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Russell,

Please pull the following for -rc. It contains some i.MX specific build
and runtime fixes.

Sascha

The following changes since commit 6221f222c0ebf1acdf7abcf927178f40e1a65e2a:

  Linux 2.6.39-rc2 (2011-04-05 18:30:43 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Dave Martin (1):
      ARM: mxc: Correct data alignment in headsmp.S for CONFIG_THUMB2_KERNEL

Fabio Estevam (1):
      ARM: mx5/mx53_loco: Fix build warning related to gpio_keys_button structure

Thomas Gleixner (1):
      ARM: mxc: Add missing lockdep annotation

Uwe Kleine-K?nig (2):
      ARM: imx: fix usb related build failure for mach-vpr200
      ARM: mxs/clock-mx28: fix up name##_set_rate

 arch/arm/mach-mx3/mach-vpr200.c     |   11 ++++++++---
 arch/arm/mach-mx5/board-mx53_loco.c |    2 +-
 arch/arm/mach-mxs/clock-mx28.c      |    7 ++++++-
 arch/arm/plat-mxc/gpio.c            |    7 +++++++
 arch/arm/plat-mxc/ssi-fiq.S         |    2 ++
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
