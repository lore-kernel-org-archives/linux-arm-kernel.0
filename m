From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  8 Oct 2013 16:47:47 +0530
Subject: [PATCH 09/10] clk: ux500: Remove extra semicolon
In-Reply-To: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1381231068-6053-9-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extra semicolon is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/clk-prcmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index 293a288..e2d63bc 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -36,7 +36,7 @@ static int clk_prcmu_prepare(struct clk_hw *hw)
 	if (!ret)
 		clk->is_prepared = 1;
 
-	return ret;;
+	return ret;
 }
 
 static void clk_prcmu_unprepare(struct clk_hw *hw)
-- 
1.7.9.5
