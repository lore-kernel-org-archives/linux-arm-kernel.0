From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  4 Nov 2013 10:24:03 +0100
Subject: [PATCH] ARM: orion5x: drop unused include from common.c
Message-ID: <1383557043-18891-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/times.h only defines CLOCK_TICK_RATE, cycles_t and get_cycles. All
three are not used in this file.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-orion5x/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 91a5852..afa6b08 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -24,7 +24,6 @@
 #include <asm/page.h>
 #include <asm/setup.h>
 #include <asm/system_misc.h>
-#include <asm/timex.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-- 
1.8.4.rc3
