From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 20 Feb 2017 21:00:42 +0900
Subject: [RESEND PATCH] pinctrl: uniphier: change pin names of aio/xirq for
 LD11
Message-ID: <1487592042-22828-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This patch changes pin names of AIO and XIRQ according to updated
specification.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Hi Linus,

If it is not too late, please queue up this patch
for Linux 4.11-rc1.

(Please discard the previous one.)


Thanks,
Masahiro


 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
index 77a0236..83f8864 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
@@ -390,22 +390,22 @@ static const struct pinctrl_pin_desc uniphier_ld11_pins[] = {
 	UNIPHIER_PINCTRL_PIN(140, "AO1D0", 140,
 			     140, UNIPHIER_PIN_DRV_1BIT,
 			     140, UNIPHIER_PIN_PULL_DOWN),
-	UNIPHIER_PINCTRL_PIN(141, "TCON0", 141,
+	UNIPHIER_PINCTRL_PIN(141, "AO1D1", 141,
 			     141, UNIPHIER_PIN_DRV_1BIT,
 			     141, UNIPHIER_PIN_PULL_DOWN),
-	UNIPHIER_PINCTRL_PIN(142, "TCON1", 142,
+	UNIPHIER_PINCTRL_PIN(142, "AO1D2", 142,
 			     142, UNIPHIER_PIN_DRV_1BIT,
 			     142, UNIPHIER_PIN_PULL_DOWN),
-	UNIPHIER_PINCTRL_PIN(143, "TCON2", 143,
+	UNIPHIER_PINCTRL_PIN(143, "XIRQ9", 143,
 			     143, UNIPHIER_PIN_DRV_1BIT,
 			     143, UNIPHIER_PIN_PULL_DOWN),
-	UNIPHIER_PINCTRL_PIN(144, "TCON3", 144,
+	UNIPHIER_PINCTRL_PIN(144, "XIRQ10", 144,
 			     144, UNIPHIER_PIN_DRV_1BIT,
 			     144, UNIPHIER_PIN_PULL_DOWN),
-	UNIPHIER_PINCTRL_PIN(145, "TCON4", 145,
+	UNIPHIER_PINCTRL_PIN(145, "XIRQ11", 145,
 			     145, UNIPHIER_PIN_DRV_1BIT,
 			     145, UNIPHIER_PIN_PULL_DOWN),
-	UNIPHIER_PINCTRL_PIN(146, "TCON5", 146,
+	UNIPHIER_PINCTRL_PIN(146, "XIRQ13", 146,
 			     146, UNIPHIER_PIN_DRV_1BIT,
 			     146, UNIPHIER_PIN_PULL_DOWN),
 	UNIPHIER_PINCTRL_PIN(147, "PWMA", 147,
-- 
2.7.4
