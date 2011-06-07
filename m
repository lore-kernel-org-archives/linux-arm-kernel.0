From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 7 Jun 2011 08:46:53 +0200
Subject: [GIT PULL] i.MX patches for -rc
Message-ID: <20110607064653.GI23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Please pull the following two small i.MX fixes.

Sascha


The following changes since commit 55922c9d1b84b89cb946c777fddccb3247e7df2c:

  Linux 3.0-rc1 (2011-05-29 17:43:36 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Fabio Estevam (1):
      ARM: mx51/sdma: Check the chip revision in run-time

Wolfram Sang (1):
      arm: mxs: include asm/processor.h for cpu_relax()

 arch/arm/mach-mxs/ocotp.c                    |    2 ++
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
