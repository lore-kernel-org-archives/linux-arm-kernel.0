From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 15 Mar 2016 22:53:05 +0530
Subject: [PATCH 0/7] dmaengine: xilinx_vdma: AXI DMA's enhancments
Message-ID: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does some enhancments to the VDMA driver
which includes
--> Adding support for AXI DMA IP.
--> Adding support for AXI CDMA IP.
--> Fixing checkpatch warnings.

Kedareswara rao Appana (7):
  dmaengine: xilinx_vdma: Fix checkpatch.pl warnings
  dmaengine: xilinx_vdma: Add quirks support to differentiate differnet
    IP cores
  dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
    Access Engine
  dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
    Access Engine
  dmaengine: xilinx_vdma: Remove unnecessary axi dma device-tree binding
    doc
  dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
    Memory Access Engine
  dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
    Memory Access Engine

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  65 ---
 .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |  37 +-
 drivers/dma/xilinx/xilinx_vdma.c                   | 593 +++++++++++++++++++--
 3 files changed, 574 insertions(+), 121 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt

-- 
2.1.2
