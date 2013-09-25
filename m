From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 25 Sep 2013 16:08:46 -0300
Subject: [PATCH] clk: fixed-factor: Fix a trivial typo
Message-ID: <1380136126-15503-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a trivial print message typo fix.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clk/clk-fixed-factor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 0e1d89b..d9e3f67 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -117,7 +117,7 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
 	}
 
 	if (of_property_read_u32(node, "clock-mult", &mult)) {
-		pr_err("%s Fixed factor clock <%s> must have a clokc-mult property\n",
+		pr_err("%s Fixed factor clock <%s> must have a clock-mult property\n",
 			__func__, node->name);
 		return;
 	}
-- 
1.8.1.5
