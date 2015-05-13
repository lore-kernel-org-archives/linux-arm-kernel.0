From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 13 May 2015 10:52:30 +0200
Subject: [PATCH 02/15] thermal: trivial: fix typo in comment
In-Reply-To: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1431507163-19933-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 62cc82a..244784f 100644
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
