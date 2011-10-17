From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Oct 2011 22:24:27 +0100
Subject: [PATCH 2/2] gpio/samsung: Fix typo in comment
In-Reply-To: <1318886667-3320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318886667-3320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1318886667-3320-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/gpio/gpio-samsung.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index ce15c7f..90455de 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -230,7 +230,7 @@ static int samsung_gpio_setcfg_2bit(struct samsung_gpio_chip *chip,
  * @chip: The gpio chip that is being configured.
  * @off: The offset for the GPIO being configured.
  *
- * The reverse of samsung_gpio_setcfg_2bit(). Will return a value whicg
+ * The reverse of samsung_gpio_setcfg_2bit(). Will return a value which
  * could be directly passed back to samsung_gpio_setcfg_2bit(), from the
  * S3C_GPIO_SPECIAL() macro.
  */
-- 
1.7.6.3
