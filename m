From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 23 Oct 2012 18:28:00 +0200
Subject: [PATCH 1/1] pinctrl: at91: fix typo on PULL_UP
Message-ID: <1351009680-15892-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-at91.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index c87c2c5..0757e94 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -58,7 +58,7 @@ static struct at91_gpio_chip *gpio_chips[MAX_GPIO_BANKS];
 
 static int gpio_banks;
 
-#define PULL_UP		(0 << 1)
+#define PULL_UP		(1 << 0)
 #define MULTI_DRIVE	(1 << 1)
 
 /**
-- 
1.7.10.4
