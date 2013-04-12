From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:29 +0200
Subject: [PATCH v5 13/14] clocksource: samsung-pwm: Drop unnecessary includes
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-14-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes unneccessary header inclusions from the samsung-pwm
clocksource driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index 99c376d..b816b65 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -24,14 +24,8 @@
 
 #include <clocksource/samsung_pwm.h>
 
-#include <asm/smp_twd.h>
-#include <asm/mach/time.h>
-#include <asm/mach/arch.h>
 #include <asm/sched_clock.h>
 
-#include <plat/devs.h>
-#include <plat/samsung-time.h>
-
 /*
  * PWM master driver
  */
-- 
1.8.1.5
