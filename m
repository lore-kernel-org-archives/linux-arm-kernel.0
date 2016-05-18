From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Wed, 18 May 2016 13:17:29 +0530
Subject: [PATCH v2 0/4] dmaengine: vdma: AXI DMA's enhancments
Message-ID: <1463557653-1687-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the following
---> Add support for cyclic DMA mode for the AXI DMA IP.
---> use dma_poll_zalloc instead of dma_pool_alloc.
---> Add 64-bit addressing support for AXI DMA IP.
---> Add 64-bit addressing support for AXI CDMA IP.

Kedareswara rao Appana (4):
  dmaengine: vdma: Add support for cyclic dma mode
  dmaengine: vdma: Use dma_pool_zalloc
  dmaengine: vdma: Add 64 bit addressing support for the axi dma
  dmaengine: vdma: Add 64 bit addressing support for the axi cdma

 drivers/dma/xilinx/xilinx_vdma.c | 293 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 260 insertions(+), 33 deletions(-)

-- 
2.1.2
