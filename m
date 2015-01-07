From: mchitale@apm.com (Mayuresh Chitale)
Date: Wed,  7 Jan 2015 10:58:53 +0530
Subject: [PATCH 0/4] APM X-Gene PCIe DMA driver
Message-ID: <1420608537-12296-1-git-send-email-mchitale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the APM X-Gene SOC PCIe DMA driver.
It can be used to transfer data between PCIe RC and PCIe 
endpoints. It supports only dma slave transfers.

Mayuresh Chitale (4):
  MAINTAINERS: Add entry for X-Gene PCIE DMA driver
  Documentation: dt-bindings: Add the binding info for APM X-Gene PCIe
    DMA driver
  arm64: dts: Add APM X-Gene PCIe DMA device tree nodes
  dma: X-Gene PCIE DMA Driver

 .../devicetree/bindings/dma/xgene-pciedma.txt      |  16 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  40 ++
 drivers/dma/Kconfig                                |  11 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/xgene-pcie-dma.c                       | 709 +++++++++++++++++++++
 6 files changed, 785 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xgene-pciedma.txt
 create mode 100644 drivers/dma/xgene-pcie-dma.c

-- 
2.2.1.212.gc5b9256
