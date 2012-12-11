From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 11 Dec 2012 14:35:54 +0100
Subject: [PATCH 1/2] pinctrl: fix comment mistake
Message-ID: <1355232954-16559-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This variable pertains to pinctrl handles not muxes
specifically.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 5cdee86..59f5a96 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -700,7 +700,7 @@ static struct pinctrl *create_pinctrl(struct device *dev)
 		}
 	}
 
-	/* Add the pinmux to the global list */
+	/* Add the pinctrl handle to the global list */
 	list_add_tail(&p->node, &pinctrl_list);
 
 	return p;
-- 
1.7.11.3
