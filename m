From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 1 Feb 2011 11:01:51 +0100
Subject: i.MX Pull request for -rc
Message-ID: <20110201100151.GP9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull the following for -rc.

Sascha

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:

  Linux 2.6.38-rc2 (2011-01-21 19:01:34 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Fabio Estevam (2):
      ARM: imx: Add VPR200 and MX51_3DS entries to uncompress.h
      ARM: mach-imx/mach-mx25_3ds: Fix section type

Sascha Hauer (4):
      ARM i.MX28: fix bit operation
      ARM i.MX28: use correct register for setting the rate
      ARM i.MX23/28: remove secondary field from struct clk. It's unused
      ARM i.MX23: use correct register for setting the rate

Shawn Guo (1):
      ARM: mxs: fix clock base address missing

Uwe Kleine-K?nig (2):
      ARM: mxs: acknowledge gpio irq
      ARM: mxs/imx28: remove now unused clock lookup "fec.0"

 arch/arm/mach-imx/mach-mx25_3ds.c           |    2 +-
 arch/arm/mach-mxs/clock-mx23.c              |    4 ++--
 arch/arm/mach-mxs/clock-mx28.c              |    7 +++----
 arch/arm/mach-mxs/clock.c                   |    2 --
 arch/arm/mach-mxs/gpio.c                    |    2 ++
 arch/arm/mach-mxs/include/mach/clock.h      |    2 --
 arch/arm/plat-mxc/include/mach/uncompress.h |    2 ++
 7 files changed, 10 insertions(+), 11 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
