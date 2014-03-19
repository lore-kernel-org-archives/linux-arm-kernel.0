From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 19 Mar 2014 15:19:33 -0300
Subject: [PATCH 4/4] clk: sunxi: fix thinko in comment
In-Reply-To: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1395253173-30437-5-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should read MOD0 and not MMC; MMC is just one example of a MOD0
clock.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 0393f85..4369c1f 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -357,7 +357,7 @@ static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
 
 /**
  * sun4i_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
- * MMC rate is calculated as follows
+ * MOD0 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
  */
 
-- 
1.9.0
