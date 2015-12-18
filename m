From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:01 +0100
Subject: [PATCH 48/69] clocksource/drivers/h8300_timer16: Remove pointless
 headers
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-48-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers are not needed, remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index cdf0d83..1c9dd02 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -4,25 +4,15 @@
  *  Copyright 2015 Yoshinori Sato <ysato@users.sourcefoge.jp>
  */
 
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/clocksource.h>
-#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#include <asm/segment.h>
-#include <asm/irq.h>
-
 #define TSTR	0
 #define TSNC	1
 #define TMDR	2
-- 
1.9.1
