From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:51:41 +0200
Subject: [PATCH 83/92] clocksource/drivers/prima2: Remove useless header
 <asm/mach/time.h>
In-Reply-To: <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467111111-12587-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467111111-12587-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver includes the <asm/mach/time.h> header but it is pointless.

Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-prima2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index dae8a66..c32148e 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -19,7 +19,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/sched_clock.h>
-#include <asm/mach/time.h>
 
 #define PRIMA2_CLOCK_FREQ 1000000
 
-- 
1.9.1
