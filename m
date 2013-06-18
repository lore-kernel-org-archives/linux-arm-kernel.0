From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Jun 2013 20:50:28 +0530
Subject: [PATCH V3 04/14] watchdog/mpcore_wdt: Arrange #includes in
 alphabetical order
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Message-ID: <08f462c86d446d56291c19d70ee89d32661ba94c.1371535242.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 6e7afe0..ca9afa7 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -20,16 +20,16 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/types.h>
-#include <linux/watchdog.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
-#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
 
 #include <asm/smp_twd.h>
 
-- 
1.7.12.rc2.18.g61b472e
