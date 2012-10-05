From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 5 Oct 2012 21:24:50 +0530
Subject: [PATCH 14/15] mtd: nand: omap: gpmc header removal
In-Reply-To: <cover.1349450454.git.afzal@ti.com>
References: <cover.1349450454.git.afzal@ti.com>
Message-ID: <483b3586b25cfe4069e9a1953733a94814b3db7b.1349450454.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nand driver no longer needs gpmc header, remove it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/mtd/nand/omap2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index e3fc8d7..d6664d7 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -28,7 +28,6 @@
 #endif
 
 #include <plat/dma.h>
-#include <plat/gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #define	DRIVER_NAME	"omap2-nand"
-- 
1.7.12
