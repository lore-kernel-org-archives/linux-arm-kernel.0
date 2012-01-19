From: b32955@freescale.com (Huang Shijie)
Date: Thu, 19 Jan 2012 14:16:01 +0800
Subject: [PATCH 04/10] MTD/GPMI : change the DMA header file
In-Reply-To: <1326953767-24155-1-git-send-email-b32955@freescale.com>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Message-ID: <1326953767-24155-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change the DMA header file for GPMI NAND driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index e023bcc..1c7fdbb 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -20,7 +20,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <mach/dma.h>
+#include <linux/mxs-dma.h>
 
 struct resources {
 	void          *gpmi_regs;
-- 
1.7.0.4
