From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:03 +0100
Subject: [PATCH 50/69] clocksource/drivers/h8300_timer16: Remove unused fields
 in timer16_priv
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-50-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fields are not used in the code, remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index bc9289b..6705bf7 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -25,8 +25,6 @@ struct timer16_priv {
 	unsigned long total_cycles;
 	unsigned long mapbase;
 	unsigned long mapcommon;
-	unsigned long flags;
-	unsigned short gra;
 	unsigned short cs_enabled;
 	unsigned char enb;
 	unsigned char imfa;
-- 
1.9.1
