From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat,  1 Oct 2016 21:46:24 +0200
Subject: [PATCH 07/15] clk: sunxi: mod0: improve function-level documentation
In-Reply-To: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1475351192-27079-8-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the actual function name in the function documentation.

Issue detected using Coccinelle (http://coccinelle.lip6.fr/)

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/clk/sunxi/clk-mod0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index e54266c..4417ae1 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -24,7 +24,7 @@
 #include "clk-factors.h"
 
 /**
- * sun4i_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
+ * sun4i_a10_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
  * MOD0 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
  */
