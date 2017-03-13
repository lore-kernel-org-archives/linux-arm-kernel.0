From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 13 Mar 2017 16:06:37 +0100
Subject: [PATCH 0/2] Add STM32 MDMA driver
Message-ID: <1489417599-31308-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 MDMA controller.
The Master Direct memory access (MDMA) provides high-speed data transfer
between memory and memory or between peripherals and memory.
Contrary to STM32 DMA, the STM32 MDMA controller supports hardware LLI and
uses a larger integrated FIFO (128 vs 16 bytes)

M'boumba Cedric Madianga (2):
  dt-bindings: Document the STM32 MDMA bindings
  dmaengine: Add STM32 MDMA driver

 .../devicetree/bindings/dma/stm32-mdma.txt         |   94 ++
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/stm32-mdma.c                           | 1570 ++++++++++++++++++++
 4 files changed, 1677 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt
 create mode 100644 drivers/dma/stm32-mdma.c

-- 
1.9.1
