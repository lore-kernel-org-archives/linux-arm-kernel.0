From: b35083@freescale.com (Jingchang Lu)
Date: Fri, 12 Apr 2013 14:57:02 +0800
Subject: [PATCH 0/3] ARM: add Freescale Vybrid family platform and development
 board support
Message-ID: <1365749825-20601-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale Vybrid family microprocessors are built on
an asymmetrical-multiprocessing architecture using ARM Cortex-A5
and Cortex-M4. These series contain the support for MVF600 Soc and
Vybrid Tower development board.

----------------------------------------------------------------
Jingchang Lu (3):
	ARM/MVF600: add Vybrid Family platform support
	ARM:DTS:MVF600: add basic device tree source
	pinctrl: add MVF pinctrl driver

 Documentation/devicetree/bindings/pinctrl/fsl,mvf-pinctrl.txt |  825 ++++++++++++
 arch/arm/boot/dts/imx-mvf600.dtsi                             |  442 +++++++
 arch/arm/boot/dts/imx-mvf600twr.dts                           |   82 ++
 arch/arm/mach-imx/Kconfig                                     |   39 +
 arch/arm/mach-imx/Makefile                                    |    4 +
 arch/arm/mach-imx/Makefile.boot                               |    4 +
 arch/arm/mach-imx/clk-mvf.c                                   |  320 +++++
 arch/arm/mach-imx/common.h                                    |    3 +
 arch/arm/mach-imx/mach-mvf600.c                               |  121 ++
 arch/arm/mach-imx/pit.c                                       |  254 ++++
 drivers/pinctrl/Kconfig                                       |    8 +
 drivers/pinctrl/Makefile                                      |    1 +
 drivers/pinctrl/pinctrl-mvf.c                                 | 2042 +++++++++++++++++++++++++++++
 13 files changed, 4145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,mvf-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx-mvf600.dtsi
 create mode 100644 arch/arm/boot/dts/imx-mvf600twr.dts
 create mode 100644 arch/arm/mach-imx/clk-mvf.c
 create mode 100644 arch/arm/mach-imx/mach-mvf600.c
 create mode 100644 arch/arm/mach-imx/pit.c
 create mode 100644 drivers/pinctrl/pinctrl-mvf.c
