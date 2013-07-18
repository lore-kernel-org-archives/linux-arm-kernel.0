From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Jul 2013 19:39:19 -0700
Subject: [PATCH 1/3] clocksource: orion: Use linux/sched_clock.h
In-Reply-To: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
References: <1374115161-675-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374115161-675-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sched_clock.h include is under include/linux now.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/time-orion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index ecbeb68..9c7f018 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -19,7 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
-#include <asm/sched_clock.h>
+#include <linux/sched_clock.h>
 
 #define TIMER_CTRL		0x00
 #define  TIMER0_EN		BIT(0)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
