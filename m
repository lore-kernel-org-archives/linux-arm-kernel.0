From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Feb 2012 14:36:23 +0100
Subject: [GIT PULL] i.MX clk_prepare/unprepare
Message-ID: <20120201133623.GT1990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Please pull the following for next. This series contains the
clk_prepare/clk_unprepare patches for i.MX.

Sascha

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git features/imx-clk-prepare

Richard Zhao (11):
      ARM: mxc: time: add clk_prepare/clk_unprepare
      ARM: mxc: ahci: add clk_prepare/clk_unprepare
      ARM: mxc: pwm: add clk_prepare/clk_unprepare
      ARM: mxc: epit: add clk_prepare/clk_unprepare
      ARM: mxc: arch_reset: add clk_prepare/clk_unprepare
      ARM: mxc: audmux-v2: add clk_prepare/clk_unprepare
      ARM: pm-imx5: add clk_prepare/clk_unprepare
      ARM: mx31moboard: add clk_prepare/clk_unprepare
      serial: imx: add clk_prepare/clk_unprepare
      i2c: imx: add clk_prepare/clk_unprepare
      mmc: sdhci-esdhc-imx: add clk_prepare/clk_unprepare

 arch/arm/mach-imx/mach-mx31moboard.c          |    2 +-
 arch/arm/mach-imx/pm-imx5.c                   |    4 ++--
 arch/arm/plat-mxc/audmux-v2.c                 |    8 ++++----
 arch/arm/plat-mxc/devices/platform-ahci-imx.c |   16 ++++++++--------
 arch/arm/plat-mxc/epit.c                      |    2 +-
 arch/arm/plat-mxc/pwm.c                       |    4 ++--
 arch/arm/plat-mxc/system.c                    |    2 +-
 arch/arm/plat-mxc/time.c                      |    2 +-
 drivers/i2c/busses/i2c-imx.c                  |    4 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c            |    6 +++---
 drivers/tty/serial/imx.c                      |    7 +++----
 11 files changed, 28 insertions(+), 29 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
