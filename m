From: b35083@freescale.com (Jingchang Lu)
Date: Fri, 8 Nov 2013 18:01:52 +0800
Subject: [PATCHv7 0/3] dma: Add Freescale eDMA engine driver support
Message-ID: <1383904915-27634-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add Freescale eDMA engine support.

Jingchang Lu (3):
	ARM: imx: Add DMAMUX clock for Vybrid vf610 SoC
	ARM: dts: vf610: Add eDMA node
	dma: Add Freescale eDMA engine driver support

 Documentation/devicetree/bindings/dma/fsl-edma.txt |  84 ++++
 arch/arm/boot/dts/vf610.dtsi                       |  49 +++
 arch/arm/mach-imx/clk-vf610.c                      |   5 +
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/fsl-edma.c                             | 944 +++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/vf610-clock.h            |   6 +-
 include/dt-bindings/dma/vf610-edma.h               | 103 +++++
 8 files changed, 1201 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
 create mode 100644 drivers/dma/fsl-edma.c
 create mode 100644 include/dt-bindings/dma/vf610-edma.h
