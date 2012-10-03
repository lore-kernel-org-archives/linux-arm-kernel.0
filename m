From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  3 Oct 2012 16:00:27 -0700
Subject: [PATCH 2/4] cpufreq: OMAP: remove unused <plat/omap-pm.h>
In-Reply-To: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
References: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1349305229-28480-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

The <plat/*.h> headers are going away, and this one is not used.  remove it.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 0fe395a..7d4d455 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -31,7 +31,6 @@
 #include <asm/cpu.h>
 
 #include <plat/clock.h>
-#include <plat/omap-pm.h>
 #include <plat/common.h>
 #include <plat/omap_device.h>
 
-- 
1.7.9.2
