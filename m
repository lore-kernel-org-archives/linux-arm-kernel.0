From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 27 Apr 2012 07:55:07 +0200
Subject: [PATCH] ARM: imx/eukrea_mbimx27-baseboard: fix typo in error message
Message-ID: <1335506107-15476-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 5f2f91d..b46cab0 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -243,7 +243,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 static void __maybe_unused ads7846_dev_init(void)
 {
 	if (gpio_request(ADS7846_PENDOWN, "ADS7846 pendown") < 0) {
-		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
+		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 		return;
 	}
 	gpio_direction_input(ADS7846_PENDOWN);
-- 
1.7.10
