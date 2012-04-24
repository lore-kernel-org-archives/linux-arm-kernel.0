From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 24 Apr 2012 15:21:16 +0200
Subject: [PATCH] pinctrl: fix dangling comment
Message-ID: <1335273676-22212-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This comment was referring to an older PINMUX define, it should
be PINCTRL now.

Reported-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/pinctrl/machine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index e4d1de7..9c4a198 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -163,5 +163,5 @@ static inline int pinctrl_register_mappings(struct pinctrl_map const *map,
 	return 0;
 }
 
-#endif /* !CONFIG_PINMUX */
+#endif /* !CONFIG_PINCTRL */
 #endif
-- 
1.7.9.2
