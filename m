From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 28 Apr 2011 03:46:04 +0200
Subject: [PATCH] PXA: Fix typo in proc-xscale.S
Message-ID: <1303955164-22197-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mm/proc-xscale.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index ce233bc..42af976 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -395,7 +395,7 @@ ENTRY(xscale_dma_a0_map_area)
 	teq	r2, #DMA_TO_DEVICE
 	beq	xscale_dma_clean_range
 	b	xscale_dma_flush_range
-ENDPROC(xscsale_dma_a0_map_area)
+ENDPROC(xscale_dma_a0_map_area)
 
 /*
  *	dma_unmap_area(start, size, dir)
-- 
1.7.4.1
