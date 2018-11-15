From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Nov 2018 11:00:37 +0100
Subject: [PATCH] clockevents/drivers/tegra20: Remove obsolete inclusion of
 <asm/smp_twd.h>
Message-ID: <20181115100037.17706-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit da4a686a2cfb077a ("ARM: smp_twd: convert to use CLKSRC_OF
init"), this header file is no longer used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clocksource/tegra20_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index aa624885e0e239df..4293943f4e2b471e 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -30,7 +30,6 @@
 #include <linux/delay.h>
 
 #include <asm/mach/time.h>
-#include <asm/smp_twd.h>
 
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
-- 
2.17.1
