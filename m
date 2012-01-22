From: stigge@antcom.de (Roland Stigge)
Date: Sun, 22 Jan 2012 18:57:57 +0100
Subject: [PATCH] Correct bad gpio naming
Message-ID: <4F1C4E25.6070801@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the GPIO names in drivers/gpio/gpio-lpc32xx.c
was bad. Renaming gpi000 -> gpio00

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 5b69480..ddfacc5 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -96,7 +96,7 @@ static const char *gpio_p2_names[LPC32XX_GPIO_P2_MAX] = {
 };
  static const char *gpio_p3_names[LPC32XX_GPIO_P3_MAX] = {
-	"gpi000", "gpio01", "gpio02", "gpio03",
+	"gpio00", "gpio01", "gpio02", "gpio03",
 	"gpio04", "gpio05"
 };
