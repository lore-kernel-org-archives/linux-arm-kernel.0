From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 17 Jan 2014 17:05:52 +0530
Subject: [PATCH 1/1] clk: samsung: Remove unneeded semicolon
Message-ID: <1389958552-15889-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Semicolon not needed after switch statement.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-pll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index f2372fca0136..8538ffe042ce 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -375,7 +375,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		break;
 	default:
 		break;
-	};
+	}
 
 	/* Set new configuration. */
 	__raw_writel(con1, pll->con_reg + 0x4);
-- 
1.7.9.5
