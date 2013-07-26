From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 26 Jul 2013 16:03:38 +0200
Subject: [PATCH] ARM: clocksource: moxart: add bitops.h include
In-Reply-To: <51EB0265.2030508@linaro.org>
References: <51EB0265.2030508@linaro.org>
Message-ID: <1374847418-21436-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bitops.h included implicitly, add #include <linux/bitops.h>

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Hi Daniel,
    
    A separate patch for moxart clocksource (already merged), as you requested.
    
    Can be applied directly to timers/clockevents-next.
    
    Best regards,
    Jonas

 drivers/clocksource/moxart_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
index 08a5943..5eb2c35 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/io.h>
 #include <linux/clocksource.h>
+#include <linux/bitops.h>
 
 #define TIMER1_BASE		0x00
 #define TIMER2_BASE		0x10
-- 
1.8.2.1
