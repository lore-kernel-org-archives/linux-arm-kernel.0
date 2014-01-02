From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 2 Jan 2014 14:52:22 +0800
Subject: [PATCHv8 0/2] dma: Add Freescale eDMA engine driver support
Message-ID: <1388645544-5596-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add Freescale eDMA engine support.

Jingchang Lu (2):
	ARM: dts: vf610: Add eDMA node
	dma: Add Freescale eDMA engine driver support

 Documentation/devicetree/bindings/dma/fsl-edma.txt |  67 ++++
 arch/arm/boot/dts/vf610.dtsi                       |  31 ++
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/fsl-edma.c                             | 939 +++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/dma/vf610-edma.h               | 195 ++++++++++
 6 files changed, 1243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
 create mode 100644 drivers/dma/fsl-edma.c
 create mode 100644 include/dt-bindings/dma/vf610-edma.h
