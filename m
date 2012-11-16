From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Nov 2012 16:52:42 +0100
Subject: [GIT PULL] i.MX dt updates
Message-ID: <20121116155242.GY10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the following i.MX dt updates for next merge window

Sascha

The following changes since commit 53640f41b97792b0889bb70f26f99c06743162a1:

  Merge remote-tracking branch 'arm-soc/imx/multiplatform' into imx25-dt (2012-11-12 12:08:12 +0100)

are available in the git repository at:


  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-dt

for you to fetch changes up to 632506a21a3b5f0596e89d55cda6b482bec331a3:

  Add device tree file for the armadeus apf27 (2012-11-16 09:12:00 +0100)

----------------------------------------------------------------
ARM i.MX dt updates for 3.8

----------------------------------------------------------------
Philippe Reynes (1):
      Add device tree file for the armadeus apf27

Sascha Hauer (4):
      ARM i.MX25: Add missing clock gates
      ARM i.MX25: Add devicetree support
      ARM i.MX25: Add devicetree
      ARM i.MX: Add Ka-Ro TX25 devicetree

 .../devicetree/bindings/clock/imx25-clock.txt      |  162 ++++++
 arch/arm/boot/dts/imx25-karo-tx25.dts              |   44 ++
 arch/arm/boot/dts/imx25.dtsi                       |  515 ++++++++++++++++++++
 arch/arm/boot/dts/imx27-apf27.dts                  |   89 ++++
 arch/arm/mach-imx/Kconfig                          |    7 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clk-imx25.c                      |  119 ++++-
 arch/arm/mach-imx/common.h                         |    1 +
 arch/arm/mach-imx/imx25-dt.c                       |   48 ++
 9 files changed, 974 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
 create mode 100644 arch/arm/boot/dts/imx25-karo-tx25.dts
 create mode 100644 arch/arm/boot/dts/imx25.dtsi
 create mode 100644 arch/arm/boot/dts/imx27-apf27.dts
 create mode 100644 arch/arm/mach-imx/imx25-dt.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
