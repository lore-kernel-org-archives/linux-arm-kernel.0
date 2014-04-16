From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Apr 2014 14:57:48 +0200
Subject: [PATCH] pinctrl: sunxi: fix typo in module author address
Message-ID: <1397653068-21788-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the MODULE_AUTHOR() comments, the author name should be
"Name <email>" or just "Name". Add the missing '>'.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index f9fabe9bf47d..1b0539f40e3b 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -933,6 +933,6 @@ static struct platform_driver sunxi_pinctrl_driver = {
 };
 module_platform_driver(sunxi_pinctrl_driver);
 
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard at free-electrons.com");
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("Allwinner A1X pinctrl driver");
 MODULE_LICENSE("GPL");
-- 
1.8.3.2
