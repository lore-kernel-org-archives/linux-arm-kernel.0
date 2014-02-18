From: b35083@freescale.com (Jingchang Lu)
Date: Tue, 18 Feb 2014 10:17:10 +0800
Subject: [PATCH RESEND v11 0/2] dma: Add Freescale eDMA engine driver support
Message-ID: <1392689832-17011-1-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add Freescale eDMA engine support.

Jingchang Lu (2):
      ARM: dts: vf610: Add eDMA node
      dma: Add Freescale eDMA engine driver support

 Documentation/devicetree/bindings/dma/fsl-edma.txt |  76 ++
 arch/arm/boot/dts/vf610.dtsi                       |  30 +
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/fsl-edma.c                             | 975 +++++++++++++++++++++
 5 files changed, 1092 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
 create mode 100644 drivers/dma/fsl-edma.c
