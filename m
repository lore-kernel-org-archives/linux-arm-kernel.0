From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:38 +0100
Subject: [PATCH 25/69] clocksource/drivers/vt8500: Remove unneeded header
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-25-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the <asm/time.h> header inclusion which is pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/vt8500_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index a92e94b..de49805 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -30,7 +30,6 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/delay.h>
-#include <asm/mach/time.h>
 
 #include <linux/of.h>
 #include <linux/of_address.h>
-- 
1.9.1
