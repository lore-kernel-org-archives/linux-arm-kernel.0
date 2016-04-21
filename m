From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 21 Apr 2016 16:08:35 +0530
Subject: [PATCH v3 0/3] dmaengine: Add clock support for AXI DMAS
Message-ID: <1461235118-800-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds basic clock support for AXI DMAS
This patch series is created on top of the 
"dmaengine: vdma: AXI DMA's enhancments" patch series.

Kedareswara rao Appana (3):
  dmaengine: vdma: Add config structure to differentiate dmas
  Documentation: DT: vdma: Add clock support for dmas
  dmaengine: vdma: Add clock support

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |  15 +
 drivers/dma/xilinx/xilinx_vdma.c                   | 304 ++++++++++++++++++---
 2 files changed, 287 insertions(+), 32 deletions(-)

-- 
2.1.2
