From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 6 Apr 2016 21:45:30 +0530
Subject: [PATCH v3 0/5] dmaengine: vdma: AXI DMA's enhancments
Message-ID: <1459959335-24083-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does some enhancments to the VDMA driver
which includes
--> Adding support for AXI DMA IP.
--> Adding support for AXI CDMA IP.

Kedareswara rao Appana (5):
  Documentation: DT: vdma: Rename vdma-chan prefix to dma-chan
  Documentation: DT: vdma: update binding doc for AXI DMA
  dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access
    Engine
  Documentation: DT: vdma: update binding doc for AXI CDMA
  dmaengine: vdma: Add Support for Xilinx AXI Central Direct Memory
    Access Engine

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |  25 +-
 drivers/dma/xilinx/xilinx_vdma.c                   | 710 +++++++++++++++++++--
 include/linux/dma/xilinx_dma.h                     |  14 +
 3 files changed, 699 insertions(+), 50 deletions(-)

-- 
2.1.2
