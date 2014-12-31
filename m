From: rsahu@apm.com (Rameshwar Prasad Sahu)
Date: Wed, 31 Dec 2014 17:08:30 +0530
Subject: [PATCH v1 0/3] dmaengine: APM X-Gene SoC DMA driver support
Message-ID: <1420025913-17597-1-git-send-email-rsahu@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set implements the APM X-Gene SoC DMA driver
support to offload the DMA operations such as memory copy(memcpy),
scatter gathering.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---

Rameshwar Prasad Sahu (3):
  dmaengine: Add support for APM X-Gene SoC DMA driver
  arm64: dts: Add APM X-Gene DMA device and DMA clock DTS node
  Documentation: dma: Add APM X-Gene SoC DMA driver documentation

 .../devicetree/bindings/dma/apm-xgene-dma.txt      |   49 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   25 +
 drivers/dma/Kconfig                                |    8 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/xgene-dma.c                            | 1506 ++++++++++++++++++++
 5 files changed, 1589 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apm-xgene-dma.txt
 create mode 100644 drivers/dma/xgene-dma.c

--
1.8.2.1
