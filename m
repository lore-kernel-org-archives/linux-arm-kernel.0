From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 2 Feb 2016 16:27:05 +0200
Subject: [PATCH 0/2] ARM: OMAP1/OMAP2+: Add dma_slave_map to board files
Message-ID: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series adds the dma_slave map to the sDMA (omap-dma) driver. The
dma_slave_map is needed later when we convert drivers to use the new dmaengine
API for requesting slave channels.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: OMAP1: DMA: Provide dma_slave_map to omap-dma
  ARM: OMAP2+: DMA: Provide dma_slave_map to omap-dma for legacy boot

 arch/arm/mach-omap1/dma.c |  45 ++++++++++++++++++
 arch/arm/mach-omap2/dma.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)

-- 
2.7.0
