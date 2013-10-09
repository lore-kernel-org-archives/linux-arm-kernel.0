From: badarkhe.manish@gmail.com (Manish Badarkhe)
Date: Wed,  9 Oct 2013 23:35:24 +0530
Subject: [PATCH] PM / devfreq: Remove duplicate include of opp.h
Message-ID: <1381341924-16184-1-git-send-email-badarkhe.manish@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, code include opp.h twice. Remove one inclusion
of opp.h

Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
---
:100644 100644 574b16b... 93c29f4... M	drivers/devfreq/exynos/exynos5_bus.c
 drivers/devfreq/exynos/exynos5_bus.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 574b16b..93c29f4 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -18,7 +18,6 @@
 #include <linux/opp.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
-#include <linux/opp.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-- 
1.7.10.4
