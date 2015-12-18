From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:54 +0100
Subject: [PATCH 41/69] clocksource/drivers/h8300_timer8: Remove unused headers
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-41-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 35b0e8f..62a7f8c 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -8,21 +8,16 @@
  */
 
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <linux/slab.h>
 #include <linux/clockchips.h>
-#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#include <asm/irq.h>
-
 #define _8TCR	0
 #define _8TCSR	2
 #define TCORA	4
-- 
1.9.1
