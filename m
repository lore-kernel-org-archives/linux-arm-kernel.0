From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 25 Nov 2013 21:43:45 +0100
Subject: [PATCH 3/3] leds/pwm: fix driver description and make license match
 the header
In-Reply-To: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1385412225-29740-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/leds-pwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index cdc3e4d..0796ca3 100644
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
1.8.4.2
