From: maxim.osipov@gmail.com (Maxim Osipov)
Date: Mon, 30 May 2011 18:13:47 +0100
Subject: [PATCH 1/1] AT91: flexibity: default leds to heartbeat
Message-ID: <1306775627-6640-1-git-send-email-maxim.osipov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes default behavior of Flexibity board LEDs to blinking
for boot diagnostic purpose.

Signed-off-by: Maxim Osipov <maxim.osipov@gmail.com>
---
 arch/arm/mach-at91/board-flexibity.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 4fdc96c..8cbec8a 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -96,49 +96,49 @@ static struct gpio_led flexibity_leds[] = {
 		.name			= "usb1:green",
 		.gpio			= AT91_PIN_PA12,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	},
 	{
 		.name			= "usb1:red",
 		.gpio			= AT91_PIN_PA13,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	},
 	{
 		.name			= "usb2:green",
 		.gpio			= AT91_PIN_PB26,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	},
 	{
 		.name			= "usb2:red",
 		.gpio			= AT91_PIN_PB27,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	},
 	{
 		.name			= "usb3:green",
 		.gpio			= AT91_PIN_PC8,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	},
 	{
 		.name			= "usb3:red",
 		.gpio			= AT91_PIN_PC6,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	},
 	{
 		.name			= "usb4:green",
 		.gpio			= AT91_PIN_PB4,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	},
 	{
 		.name			= "usb4:red",
 		.gpio			= AT91_PIN_PB5,
 		.active_low		= 1,
-		.default_trigger	= "default-on",
+		.default_trigger	= "heartbeat",
 	}
 };
 
-- 
1.7.4.1
