From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 16:26:21 +0100
Subject: [PATCH] pinctrl: mediatek/7623: delete unnecessary .owner
Message-ID: <1456413981-26089-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is set by the device core.

Cc: John Crispin <blogic@openwrt.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt7623.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7623.c b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
index bf0d05b6e7dc..67895f8234e3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7623.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
@@ -367,7 +367,6 @@ static struct platform_driver mtk_pinctrl_driver = {
 	.probe = mt7623_pinctrl_probe,
 	.driver = {
 		.name = "mediatek-mt7623-pinctrl",
-		.owner = THIS_MODULE,
 		.of_match_table = mt7623_pctrl_match,
 	},
 };
-- 
2.4.3
