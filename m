From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Mon, 2 Mar 2015 23:24:24 +0530
Subject: [PATCH] dma: xilinx-dma: move header file to common location
Message-ID: <4c3e2425e14646cb86c20d6aebdcfe22@BY2FFO11FD004.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the xilinx_dma.h header file
to the include/linux/dma.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_vdma.c         | 2 +-
 include/linux/{amba => dma}/xilinx_dma.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{amba => dma}/xilinx_dma.h (100%)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index bdd2a5d..d8434d4 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -22,9 +22,9 @@
  * (at your option) any later version.
  */
 
-#include <linux/amba/xilinx_dma.h>
 #include <linux/bitops.h>
 #include <linux/dmapool.h>
+#include <linux/dma/xilinx_dma.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
diff --git a/include/linux/amba/xilinx_dma.h b/include/linux/dma/xilinx_dma.h
similarity index 100%
rename from include/linux/amba/xilinx_dma.h
rename to include/linux/dma/xilinx_dma.h
-- 
2.1.2
