From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon, 21 Jan 2013 13:09:32 +0100
Subject: [PATCH 2/2] clocksource: dbx500-prcmu: comment cleanup
In-Reply-To: <1358770172-30125-1-git-send-email-fabio.baltieri@linaro.org>
References: <1358770172-30125-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1358770172-30125-2-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove references to the deprecated DB5500 platform.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 159f54a..6879a74 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -10,7 +10,7 @@
  * DBx500-PRCMU Timer
  * The PRCMU has 5 timers which are available in a always-on
  * power domain.  We use the Timer 4 for our always-on clock
- * source on DB8500 and Timer 3 on DB5500.
+ * source on DB8500.
  */
 #include <linux/clockchips.h>
 #include <linux/clksrc-dbx500-prcmu.h>
-- 
1.7.12.1
