From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Jul 2012 09:28:33 +0200
Subject: [GIT PULL] i.MX clk fixes and updates
Message-ID: <20120717072833.GZ30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX clk fixes and updates for next. Not
strictly divided into fixes/features, but all around clk support, hope
that's ok.

Thanks
 Sascha

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-clk

for you to fetch changes up to 14ac5b884eff23f53139dd4508f428aee906d8c2:

  ARM: imx: clk-imx31: Fix clock id for rnga driver (2012-07-16 23:25:48 +0200)

----------------------------------------------------------------
i.MX clk noncritical fixes and updates

----------------------------------------------------------------
Alexander Shiyan (4):
      ARM: i.MX5x clocks: Add EPIT support
      ARM: i.MX5x clocks: Fix parent for PWM clocks
      ARM: i.MX5x clocks: Fix GPT clocks
      ARM: i.MX5x CSPI: Fixed clock name for CSPI

Fabio Estevam (3):
      ARM: clk-imx27: Fix rtc clock id
      ARM: mx27: Reenable silicon version print
      ARM: imx: clk-imx31: Fix clock id for rnga driver

Uwe Kleine-K?nig (1):
      ARM: imx: add missing item to the list of clock event modes

 arch/arm/mach-imx/clk-imx27.c                |    4 +++-
 arch/arm/mach-imx/clk-imx31.c                |    4 ++--
 arch/arm/mach-imx/clk-imx51-imx53.c          |   23 ++++++++++++++++-------
 arch/arm/plat-mxc/devices/platform-spi_imx.c |    2 +-
 arch/arm/plat-mxc/time.c                     |    3 ++-
 5 files changed, 24 insertions(+), 12 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
