From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 18 Aug 2016 14:38:43 +0800
Subject: [PATCH v1 0/5] dma: Add QorIQ qDMA engine driver support
Message-ID: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

dma: Add QorIQ qDMA engine driver support

Yuan Yao (5):
  dma: Add QorIQ qDMA engine driver support
  dma: Add device tree binding for QorIQ qDMA driver
  MAINTAINERS: add maintainer entry for QorIQ QDMA driver
  ARM: dts: ls1043a: add qDMA node
  ARM: dts: ls1021a: add qDMA node

 .../devicetree/bindings/dma/qoriq-qdma.txt         |  38 +
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  10 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  10 +
 drivers/dma/Kconfig                                |  12 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/qoriq-qdma.c                           | 900 +++++++++++++++++++++
 drivers/dma/qoriq-qdma.h                           | 272 +++++++
 8 files changed, 1250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/qoriq-qdma.txt
 create mode 100644 drivers/dma/qoriq-qdma.c
 create mode 100644 drivers/dma/qoriq-qdma.h

-- 
2.1.0.27.g96db324
