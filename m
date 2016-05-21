From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:49:24 +0200
Subject: [PATCH 0098/1529] Fix typo
Message-ID: <20160521114924.4453-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-imx/pm-imx5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index 868781f..0d75e5f 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -51,7 +51,7 @@
  * This is also the lowest power state possible without affecting
  * non-cpu parts of the system.  For these reasons, imx5 should default
  * to always using this state for cpu idling.  The PM_SUSPEND_STANDBY also
- * uses this state and needs to take no action when registers remain confgiured
+ * uses this state and needs to take no action when registers remain configured
  * for this state.
  */
 #define IMX5_DEFAULT_CPU_IDLE_STATE WAIT_UNCLOCKED_POWER_OFF
-- 
2.8.2.534.g1f66975
