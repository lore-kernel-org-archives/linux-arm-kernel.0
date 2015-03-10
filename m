From: marek@goldelico.com (Marek Belisko)
Date: Tue, 10 Mar 2015 22:27:27 +0100
Subject: [PATCH v4 6/6] power: twl4030_madc_battery: Add missing MODULE_ALIAS
In-Reply-To: <1426022847-30912-1-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Message-ID: <1426022847-30912-7-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without MODULE_ALIAS twl4030_madc_battery won't get loaded automatically.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/twl4030_madc_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index 3e0005d..d0753f1 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -355,3 +355,4 @@ module_platform_driver(twl4030_madc_battery_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lukas M?rdian <lukas@goldelico.com>");
 MODULE_DESCRIPTION("twl4030_madc battery driver");
+MODULE_ALIAS("platform:twl4030_madc_battery");
-- 
1.9.1
