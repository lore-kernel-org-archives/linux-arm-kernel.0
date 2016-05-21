From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:25 +0200
Subject: [PATCH 0107/1529] Fix typo
Message-ID: <20160521115025.4915-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/omap_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index f7ff3b9..a7be05d 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -268,7 +268,7 @@ static int _omap_device_idle_hwmods(struct omap_device *od)
  * function returns a value different than the value the caller got
  * the last time it called this function.
  *
- * If any hwmods exist for the omap_device assoiated with @pdev,
+ * If any hwmods exist for the omap_device associated with @pdev,
  * return the context loss counter for that hwmod, otherwise return
  * zero.
  */
-- 
2.8.2.534.g1f66975
