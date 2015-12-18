From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:55 +0100
Subject: [PATCH 42/69] clocksource/drivers/h8300_timer8: Remove unused macros
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-42-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer8.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 62a7f8c..88b9b06 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -24,7 +24,6 @@
 #define TCORB	6
 #define _8TCNT	8
 
-#define FLAG_REPROGRAM (1 << 0)
 #define FLAG_SKIPEVENT (1 << 1)
 #define FLAG_IRQCONTEXT (1 << 2)
 #define FLAG_STARTED (1 << 3)
@@ -32,9 +31,6 @@
 #define ONESHOT  0
 #define PERIODIC 1
 
-#define RELATIVE 0
-#define ABSOLUTE 1
-
 #define SCALE 64
 
 struct timer8_priv {
-- 
1.9.1
