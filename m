From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  5 Feb 2016 13:08:19 +0100
Subject: [PATCH v3 1/3] fixup! Input: rotary_encoder - convert to use gpiod API
In-Reply-To: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1454674101-1194-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-pxa/raumfeld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index c559114431eb..77e412cd2766 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -368,7 +368,7 @@ static struct pxaohci_platform_data raumfeld_ohci_info = {
  */
 
 static struct gpiod_lookup_table raumfeld_rotary_gpios_table = {
-	.dev_id = "rotary-encoder",
+	.dev_id = "rotary-encoder.0",
 	.table = {
 		GPIO_LOOKUP_IDX("gpio-0",
 				GPIO_VOLENC_A, NULL, 0, GPIO_ACTIVE_LOW),
-- 
2.7.0
