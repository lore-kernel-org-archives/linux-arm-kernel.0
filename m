From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Mar 2015 16:53:49 +0100
Subject: [PATCH 02/13] thermal: trivial: fix typo in comment
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1427385240-6086-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0e4ad7c..c735ac4c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -402,7 +402,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 }
 
 /**
- * thermal_zone_get_temp() - returns its the temperature of thermal zone
+ * thermal_zone_get_temp() - returns the temperature of a thermal zone
  * @tz: a valid pointer to a struct thermal_zone_device
  * @temp: a valid pointer to where to store the resulting temperature.
  *
-- 
2.1.4
