From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 9 Nov 2012 13:36:25 +0100
Subject: [PATCH] pinctrl/nomadik: db8540: fix moduartstmmux_oc4_1 pin group
 definition.
Message-ID: <1352464585-481-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Nicolas Graux <jean-nicolas.graux@stericsson.com>

One group definition was missing, so add it.

Signed-off-by: Jean-Nicolas Graux <jean-nicolas.graux@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik-db8540.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-nomadik-db8540.c b/drivers/pinctrl/pinctrl-nomadik-db8540.c
index 52fc301..bce0583 100644
--- a/drivers/pinctrl/pinctrl-nomadik-db8540.c
+++ b/drivers/pinctrl/pinctrl-nomadik-db8540.c
@@ -822,6 +822,7 @@ static const struct nmk_pingroup nmk_db8540_groups[] = {
 	DB8540_PIN_GROUP(modaccuarttxrx_oc4_1, NMK_GPIO_ALT_C4),
 	DB8540_PIN_GROUP(modaccuartrtscts_oc4_1, NMK_GPIO_ALT_C4),
 	DB8540_PIN_GROUP(stmmod_oc4_1, NMK_GPIO_ALT_C4),
+	DB8540_PIN_GROUP(moduartstmmux_oc4_1, NMK_GPIO_ALT_C4),
 
 };
 
-- 
1.7.11.3
