From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  2 Nov 2015 13:56:41 +0100
Subject: [PATCH 13/22] clocksource/drivers/vt8500: Remove unneeded header
In-Reply-To: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1446469011-22710-13-git-send-email-daniel.lezcano@linaro.org>
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
