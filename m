From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 19 Dec 2013 14:24:00 +0530
Subject: [PATCH Resend 6/7] clk: ux500: Remove extra semicolon
In-Reply-To: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
References: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1387443241-5694-6-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extra semicolon is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/clk-prcmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index 293a28854417..e2d63bc47436 100644
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
