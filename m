From: b35083@freescale.com (Jingchang Lu)
Date: Fri, 17 Jan 2014 14:04:42 +0800
Subject: [PATCHv10 0/2] dma: Add Freescale eDMA engine driver support
Message-ID: <1389938684-29467-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add Freescale eDMA engine support.

Jingchang Lu (2):
	ARM: dts: vf610: Add eDMA node
	dma: Add Freescale eDMA engine driver support

 Documentation/devicetree/bindings/dma/fsl-edma.txt |  76 ++++
 arch/arm/boot/dts/vf610.dtsi                       |  30 ++
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/fsl-edma.c                             | 956 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1073 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
 create mode 100644 drivers/dma/fsl-edma.c
