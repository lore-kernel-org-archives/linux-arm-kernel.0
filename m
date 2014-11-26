From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 26 Nov 2014 17:19:49 +0100
Subject: [PATCH] leds/pwm: fix driver description and make license match the
 header
Message-ID: <1417018789-9235-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch was already sent a year ago with Message-Id:
<1385412225-29740-4-git-send-email-u.kleine-koenig@pengutronix.de>
without any feedback. Still applies to next-20141126.

Best regards
Uwe

 drivers/leds/leds-pwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index f668500a2157..9cfb7b348593 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -239,6 +239,6 @@ static struct platform_driver led_pwm_driver = {
 module_platform_driver(led_pwm_driver);
 
 MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
-MODULE_DESCRIPTION("PWM LED driver for PXA");
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("generic PWM LED driver");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:leds-pwm");
-- 
2.1.3
