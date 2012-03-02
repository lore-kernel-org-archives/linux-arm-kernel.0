From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 2 Mar 2012 08:32:24 +0100
Subject: [GIT PULL] i.MX27 devicetree support
Message-ID: <20120302073224.GI26642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following series adding devicetree support for i.MX27
for -next

Sascha


The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

  Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git features/imx27-dt

for you to fetch changes up to 6ad109fa3f46713a5cd28f41d872c9a4fc2bcedc:

  devicetree-bindings: Add documentation for i.MX generic boards (2012-02-29 09:16:50 +0100)

----------------------------------------------------------------
Sascha Hauer (3):
      ARM i.MX27: Add devicetree support
      ARM i.MX: Add phytec phycore-i.MX27 (aka pcm038) devicetree support
      devicetree-bindings: Add documentation for i.MX generic boards

 Documentation/devicetree/bindings/arm/fsl.txt |   22 +++
 arch/arm/boot/dts/imx27-phytec-phycore.dts    |   76 +++++++++
 arch/arm/boot/dts/imx27.dtsi                  |  217 +++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig                     |    8 +
 arch/arm/mach-imx/Makefile                    |    1 +
 arch/arm/mach-imx/clock-imx27.c               |   18 ++
 arch/arm/mach-imx/imx27-dt.c                  |   89 ++++++++++
 arch/arm/plat-mxc/include/mach/common.h       |    1 +
 8 files changed, 432 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycore.dts
 create mode 100644 arch/arm/boot/dts/imx27.dtsi
 create mode 100644 arch/arm/mach-imx/imx27-dt.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
