From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Apr 2015 10:25:53 +0200
Subject: [PATCH 03/13] thermal: trivial: Add missing whitespace in message
In-Reply-To: <1430209563-647-1-git-send-email-s.hauer@pengutronix.de>
References: <1430209563-647-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1430209563-647-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commas should be followed by a whitespace.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 244784f..cecebac 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -378,7 +378,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	if (trip_type == THERMAL_TRIP_CRITICAL) {
 		dev_emerg(&tz->device,
-			  "critical temperature reached(%d C),shutting down\n",
+			  "critical temperature reached(%d C), shutting down\n",
 			  tz->temperature / 1000);
 		orderly_poweroff(true);
 	}
-- 
2.1.4
