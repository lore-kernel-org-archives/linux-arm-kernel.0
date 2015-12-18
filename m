From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:02 +0100
Subject: [PATCH 49/69] clocksource/drivers/h8300_timer16: Remove unused macros
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-49-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros are no longer used in the code, remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index 1c9dd02..bc9289b 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -14,29 +14,11 @@
 #include <linux/of_irq.h>
 
 #define TSTR	0
-#define TSNC	1
-#define TMDR	2
-#define TOLR	3
 #define TISRA	4
-#define TISRB	5
 #define TISRC	6
 
 #define TCR	0
-#define TIOR	1
 #define TCNT	2
-#define GRA	4
-#define GRB	6
-
-#define FLAG_REPROGRAM (1 << 0)
-#define FLAG_SKIPEVENT (1 << 1)
-#define FLAG_IRQCONTEXT (1 << 2)
-#define FLAG_STARTED (1 << 3)
-
-#define ONESHOT  0
-#define PERIODIC 1
-
-#define RELATIVE 0
-#define ABSOLUTE 1
 
 struct timer16_priv {
 	struct clocksource cs;
-- 
1.9.1
