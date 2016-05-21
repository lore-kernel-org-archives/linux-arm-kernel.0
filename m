From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:56 +0200
Subject: [PATCH 0103/1529] Fix typo
Message-ID: <20160521114956.4714-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap1/include/mach/mtd-xip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/include/mach/mtd-xip.h b/arch/arm/mach-omap1/include/mach/mtd-xip.h
index f82a8dc..d09b2bc 100644
--- a/arch/arm/mach-omap1/include/mach/mtd-xip.h
+++ b/arch/arm/mach-omap1/include/mach/mtd-xip.h
@@ -39,7 +39,7 @@ static inline unsigned long xip_omap_mpu_timer_read(int nr)
 #define xip_currtime()		(~xip_omap_mpu_timer_read(0))
 
 /*
- * It's permitted to do approxmation for xip_elapsed_since macro
+ * It's permitted to do approximation for xip_elapsed_since macro
  * (see linux/mtd/xip.h)
  */
 
-- 
2.8.2.534.g1f66975
