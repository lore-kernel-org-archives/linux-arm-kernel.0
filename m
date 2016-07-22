From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jul 2016 17:45:26 +0200
Subject: [PATCH] pinctrl: xway: fix typo
Message-ID: <1469202326-9281-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A typo in the previous commit to this file needs fixing.

Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 6b4316aecec0 ("pinctrl: xway: Change structure initialisation to c99 style")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-xway.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index dac88a2a1693..f3775f823e8b 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -1647,7 +1647,7 @@ static struct pinctrl_xway_soc danube_pinctrl = {
 	.funcs = danube_funcs,
 	.num_funcs = ARRAY_SIZE(danube_funcs),
 	.exin = danube_exin_pin_map,
-	.num-exin = 3
+	.num_exin = 3
 };
 
 /* XWAY xRX100 Family */
-- 
2.7.4
