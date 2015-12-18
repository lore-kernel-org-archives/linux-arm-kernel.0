From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:52 +0100
Subject: [PATCH 39/69] clocksource/drivers/h8300_tpu: Remove unused macros
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-39-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some macros are unused, delete them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_tpu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/h8300_tpu.c b/drivers/clocksource/h8300_tpu.c
index ed0b493..576dae6 100644
--- a/drivers/clocksource/h8300_tpu.c
+++ b/drivers/clocksource/h8300_tpu.c
@@ -20,16 +20,9 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#define TCR	0
-#define TMDR	1
-#define TIOR	2
-#define TER	4
-#define TSR	5
-#define TCNT	6
-#define TGRA	8
-#define TGRB	10
-#define TGRC	12
-#define TGRD	14
+#define TCR	0x0
+#define TSR	0x5
+#define TCNT	0x6
 
 struct tpu_priv {
 	struct clocksource cs;
-- 
1.9.1
