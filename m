From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Sun, 20 Jan 2013 03:50:44 +0100
Subject: [PATCH] RX-51: Add leds lp5523 names from Maemo 5 2.6.28 kernel
Message-ID: <1358650244-29722-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 7611958..9a0dbb7 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -168,30 +168,39 @@ static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
 #if defined(CONFIG_LEDS_LP5523) || defined(CONFIG_LEDS_LP5523_MODULE)
 static struct lp5523_led_config rx51_lp5523_led_config[] = {
 	{
+		.name		= "lp5523:kb1",
 		.chan_nr	= 0,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:kb2",
 		.chan_nr	= 1,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:kb3",
 		.chan_nr	= 2,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:kb4",
 		.chan_nr	= 3,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:b",
 		.chan_nr	= 4,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:g",
 		.chan_nr	= 5,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:r",
 		.chan_nr	= 6,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:kb5",
 		.chan_nr	= 7,
 		.led_current	= 50,
 	}, {
+		.name		= "lp5523:kb6",
 		.chan_nr	= 8,
 		.led_current	= 50,
 	}
-- 
1.7.10.4
