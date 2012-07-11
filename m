From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Jul 2012 08:58:16 +0200
Subject: [GIT PULL] i.MX dt changes for v3.6
Message-ID: <20120711065816.GI30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX dt changes for v3.6

Sascha

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-dt

for you to fetch changes up to 0767211bea2f2062b1d5620eed6a279fa2b4330e:

  arm/dts: Add support for i.MX31 bug 1.x board from buglabs. (2012-07-10 19:23:03 +0200)

----------------------------------------------------------------
ARM i.MX dt updates for v3.6

----------------------------------------------------------------
Denis 'GNUtoo' Carikli (2):
      ARM i.MX31: Add devicetree support
      arm/dts: Add support for i.MX31 bug 1.x board from buglabs.

Fabio Estevam (1):
      ARM: dts: Add basic support for mx27_3ds board

 arch/arm/boot/dts/imx27-3ds.dts         |   41 ++++++++++++++
 arch/arm/boot/dts/imx31-bug.dts         |   31 +++++++++++
 arch/arm/boot/dts/imx31.dtsi            |   88 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig               |    8 +++
 arch/arm/mach-imx/Makefile              |    1 +
 arch/arm/mach-imx/clk-imx31.c           |   19 +++++++
 arch/arm/mach-imx/imx31-dt.c            |   63 ++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 8 files changed, 252 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx27-3ds.dts
 create mode 100644 arch/arm/boot/dts/imx31-bug.dts
 create mode 100644 arch/arm/boot/dts/imx31.dtsi
 create mode 100644 arch/arm/mach-imx/imx31-dt.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
