From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 19 Dec 2014 18:57:05 +0530
Subject: [PATCH] clk: samsung: exynos7: Fix fsys NR_CLK
Message-ID: <1418995625-13650-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo in fsys0 and fsys1 NR_CLK assignment

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/clk/samsung/clk-exynos7.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index 3128593..3a56875 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -742,7 +742,7 @@ static struct samsung_cmu_info fsys0_cmu_info __initdata = {
 	.nr_mux_clks		= ARRAY_SIZE(fsys0_mux_clks),
 	.gate_clks		= fsys0_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(fsys0_gate_clks),
-	.nr_clk_ids		= TOP1_NR_CLK,
+	.nr_clk_ids		= FSYS0_NR_CLK,
 	.clk_regs		= fsys0_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(fsys0_clk_regs),
 };
@@ -793,7 +793,7 @@ static struct samsung_cmu_info fsys1_cmu_info __initdata = {
 	.nr_mux_clks		= ARRAY_SIZE(fsys1_mux_clks),
 	.gate_clks		= fsys1_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(fsys1_gate_clks),
-	.nr_clk_ids		= TOP1_NR_CLK,
+	.nr_clk_ids		= FSYS1_NR_CLK,
 	.clk_regs		= fsys1_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(fsys1_clk_regs),
 };
-- 
1.7.4.4
