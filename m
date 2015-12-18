From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:53 +0100
Subject: [PATCH 40/69] clocksource/drivers/h8300_tpu: Remove pointless headers
 for TPU
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-40-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_tpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
index 576dae6..c1eef42 100644
--- a/drivers/clocksource/h8300_tpu.c
+++ b/drivers/clocksource/h8300_tpu.c
@@ -6,14 +6,9 @@
  */
 
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
-#include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/clocksource.h>
-#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
-- 
1.9.1
