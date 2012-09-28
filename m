From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 28 Sep 2012 19:10:06 +0530
Subject: [PATCH 1/4] ARM: OMAP: DMA: Removing plat/dma-44xx.h
In-Reply-To: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1348839609-10456-2-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the DMA channel definitions defined in
plat/dma-44xx.h are used. So removing it.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/include/plat/dma-44xx.h |  147 ----------------------------
 arch/arm/plat-omap/include/plat/dma.h      |    3 -
 2 files changed, 150 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/dma-44xx.h

diff --git a/arch/arm/plat-omap/include/plat/dma-44xx.h b/arch/arm/plat-omap/include/plat/dma-44xx.h
deleted file mode 100644
index 1f767cb..0000000
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 0a87b05..e413bd8 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -28,9 +28,6 @@
  * the omap drivers hwmod adapted.
  */
 
-/* Move omap4 specific defines to dma-44xx.h */
-#include "dma-44xx.h"
-
 #define INT_DMA_LCD			25
 
 /* DMA channels for omap1 */
-- 
1.7.10.4
