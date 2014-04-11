From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:40:14 +0200
Subject: [PATCH V5 19/20] ARM: exynos: cpuidle: Cleanup all unneeded headers
 from cpuidle.c
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-20-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 1d1222e..1d09ebd 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -8,25 +8,15 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
-#include <linux/io.h>
 #include <linux/export.h>
-#include <linux/time.h>
 #include <linux/platform_device.h>
 
 #include <asm/proc-fns.h>
 #include <asm/suspend.h>
-#include <asm/unified.h>
 #include <asm/cpuidle.h>
 
-#include <plat/cpu.h>
-#include <plat/pm.h>
-
-#include <mach/map.h>
-
 static void (*exynos_enter_aftr)(void);
 
 static int idle_finisher(unsigned long flags)
-- 
1.7.9.5
