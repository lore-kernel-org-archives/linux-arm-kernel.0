From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 6 Apr 2016 10:44:54 +0530
Subject: [RESEND PATCH v2 0/6] dmaengine: vdma: AXI DMA's enhancments
Message-ID: <1459919700-6692-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does some enhancments to the VDMA driver
which includes
--> Adding support for AXI DMA IP.
--> Adding support for AXI CDMA IP.
--> Fixing checkpatch warnings.

Kedareswara rao Appana (6):
  dmaengine: vdma: Fix checkpatch.pl warnings
  dmaengine: vdma: Rename xilinx_vdma_ prefix to xilinx_dma
  Documentation: DT: vdma: update binding doc for AXI DMA
  dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access
    Engine
  Documentation: DT: vdma: update binding doc for AXI CDMA
  dmaengine: vdma: Add Support for Xilinx AXI Central Direct Memory
    Access Engine

 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |   38 +-
 drivers/dma/xilinx/xilinx_vdma.c                   | 1335 ++++++++++++++------
 include/linux/dma/xilinx_dma.h                     |   14 +
 3 files changed, 1028 insertions(+), 359 deletions(-)

-- 
2.1.2
