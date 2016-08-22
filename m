From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 18:48:36 +0900
Subject: [PATCH 2/5] clk: samsung: exynos3250: Fix the checkpatch warnings
In-Reply-To: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
References: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471859319-30681-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following warnings by using checkpatch.pl script.
- Fix line 80 over characters
- Remove the space prohibited after that open parenthesis '('

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 97 ++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 1b81e283f605..cda6a85dbf9d 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -258,28 +258,38 @@ static const struct samsung_mux_clock mux_clks[] __initconst = {
 
 	/* SRC_TOP0 */
 	MUX(CLK_MOUT_EBI, "mout_ebi", mout_ebi_p, SRC_TOP0, 28, 1),
-	MUX(CLK_MOUT_ACLK_200, "mout_aclk_200", group_div_mpll_pre_p,SRC_TOP0, 24, 1),
-	MUX(CLK_MOUT_ACLK_160, "mout_aclk_160", group_div_mpll_pre_p, SRC_TOP0, 20, 1),
-	MUX(CLK_MOUT_ACLK_100, "mout_aclk_100", group_div_mpll_pre_p, SRC_TOP0, 16, 1),
-	MUX(CLK_MOUT_ACLK_266_1, "mout_aclk_266_1", mout_aclk_266_1_p, SRC_TOP0, 14, 1),
-	MUX(CLK_MOUT_ACLK_266_0, "mout_aclk_266_0", mout_aclk_266_0_p, SRC_TOP0, 13, 1),
-	MUX(CLK_MOUT_ACLK_266, "mout_aclk_266", mout_aclk_266_p, SRC_TOP0, 12, 1),
+	MUX(CLK_MOUT_ACLK_200, "mout_aclk_200", group_div_mpll_pre_p,
+			SRC_TOP0, 24, 1),
+	MUX(CLK_MOUT_ACLK_160, "mout_aclk_160", group_div_mpll_pre_p,
+			SRC_TOP0, 20, 1),
+	MUX(CLK_MOUT_ACLK_100, "mout_aclk_100", group_div_mpll_pre_p,
+			SRC_TOP0, 16, 1),
+	MUX(CLK_MOUT_ACLK_266_1, "mout_aclk_266_1", mout_aclk_266_1_p,
+			SRC_TOP0, 14, 1),
+	MUX(CLK_MOUT_ACLK_266_0, "mout_aclk_266_0", mout_aclk_266_0_p,
+			SRC_TOP0, 13, 1),
+	MUX(CLK_MOUT_ACLK_266, "mout_aclk_266", mout_aclk_266_p,
+			SRC_TOP0, 12, 1),
 	MUX(CLK_MOUT_VPLL, "mout_vpll", mout_vpll_p, SRC_TOP0, 8, 1),
-	MUX(CLK_MOUT_EPLL_USER, "mout_epll_user", mout_epll_user_p, SRC_TOP0, 4, 1),
+	MUX(CLK_MOUT_EPLL_USER, "mout_epll_user", mout_epll_user_p,
+			SRC_TOP0, 4, 1),
 	MUX(CLK_MOUT_EBI_1, "mout_ebi_1", mout_ebi_1_p, SRC_TOP0, 0, 1),
 
 	/* SRC_TOP1 */
 	MUX(CLK_MOUT_UPLL, "mout_upll", mout_upll_p, SRC_TOP1, 28, 1),
-	MUX(CLK_MOUT_ACLK_400_MCUISP_SUB, "mout_aclk_400_mcuisp_sub", mout_aclk_400_mcuisp_sub_p,
-		SRC_TOP1, 24, 1),
-	MUX(CLK_MOUT_ACLK_266_SUB, "mout_aclk_266_sub", mout_aclk_266_sub_p, SRC_TOP1, 20, 1),
+	MUX(CLK_MOUT_ACLK_400_MCUISP_SUB, "mout_aclk_400_mcuisp_sub",
+			mout_aclk_400_mcuisp_sub_p, SRC_TOP1, 24, 1),
+	MUX(CLK_MOUT_ACLK_266_SUB, "mout_aclk_266_sub", mout_aclk_266_sub_p,
+			SRC_TOP1, 20, 1),
 	MUX(CLK_MOUT_MPLL, "mout_mpll", mout_mpll_p, SRC_TOP1, 12, 1),
-	MUX(CLK_MOUT_ACLK_400_MCUISP, "mout_aclk_400_mcuisp", group_div_mpll_pre_p, SRC_TOP1, 8, 1),
+	MUX(CLK_MOUT_ACLK_400_MCUISP, "mout_aclk_400_mcuisp",
+			group_div_mpll_pre_p, SRC_TOP1, 8, 1),
 	MUX(CLK_MOUT_VPLLSRC, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP1, 0, 1),
 
 	/* SRC_CAM */
 	MUX(CLK_MOUT_CAM1, "mout_cam1", group_sclk_p, SRC_CAM, 20, 4),
-	MUX(CLK_MOUT_CAM_BLK, "mout_cam_blk", group_sclk_cam_blk_p, SRC_CAM, 0, 4),
+	MUX(CLK_MOUT_CAM_BLK, "mout_cam_blk", group_sclk_cam_blk_p,
+			SRC_CAM, 0, 4),
 
 	/* SRC_MFC */
 	MUX(CLK_MOUT_MFC, "mout_mfc", mout_mfc_p, SRC_MFC, 8, 1),
@@ -670,23 +680,23 @@ static const struct samsung_gate_clock gate_clks[] __initconst = {
 
 /* APLL & MPLL & BPLL & UPLL */
 static const struct samsung_pll_rate_table exynos3250_pll_rates[] __initconst = {
-	PLL_35XX_RATE(1200000000, 400, 4, 1),
-	PLL_35XX_RATE(1100000000, 275, 3, 1),
-	PLL_35XX_RATE(1066000000, 533, 6, 1),
-	PLL_35XX_RATE(1000000000, 250, 3, 1),
-	PLL_35XX_RATE( 960000000, 320, 4, 1),
-	PLL_35XX_RATE( 900000000, 300, 4, 1),
-	PLL_35XX_RATE( 850000000, 425, 6, 1),
-	PLL_35XX_RATE( 800000000, 200, 3, 1),
-	PLL_35XX_RATE( 700000000, 175, 3, 1),
-	PLL_35XX_RATE( 667000000, 667, 12, 1),
-	PLL_35XX_RATE( 600000000, 400, 4, 2),
-	PLL_35XX_RATE( 533000000, 533, 6, 2),
-	PLL_35XX_RATE( 520000000, 260, 3, 2),
-	PLL_35XX_RATE( 500000000, 250, 3, 2),
-	PLL_35XX_RATE( 400000000, 200, 3, 2),
-	PLL_35XX_RATE( 200000000, 200, 3, 3),
-	PLL_35XX_RATE( 100000000, 200, 3, 4),
+	PLL_35XX_RATE(1200000000, 400,  4, 1),
+	PLL_35XX_RATE(1100000000, 275,  3, 1),
+	PLL_35XX_RATE(1066000000, 533,  6, 1),
+	PLL_35XX_RATE(1000000000, 250,  3, 1),
+	PLL_35XX_RATE(960000000,  320,  4, 1),
+	PLL_35XX_RATE(900000000,  300,  4, 1),
+	PLL_35XX_RATE(850000000,  425,  6, 1),
+	PLL_35XX_RATE(800000000,  200,  3, 1),
+	PLL_35XX_RATE(700000000,  175,  3, 1),
+	PLL_35XX_RATE(667000000,  667, 12, 1),
+	PLL_35XX_RATE(600000000,  400,  4, 2),
+	PLL_35XX_RATE(533000000,  533,  6, 2),
+	PLL_35XX_RATE(520000000,  260,  3, 2),
+	PLL_35XX_RATE(500000000,  250,  3, 2),
+	PLL_35XX_RATE(400000000,  200,  3, 2),
+	PLL_35XX_RATE(200000000,  200,  3, 3),
+	PLL_35XX_RATE(100000000,  200,  3, 4),
 	{ /* sentinel */ }
 };
 
@@ -696,16 +706,16 @@ static const struct samsung_pll_rate_table exynos3250_epll_rates[] __initconst =
 	PLL_36XX_RATE(288000000,  96, 2, 2,     0),
 	PLL_36XX_RATE(192000000, 128, 2, 3,     0),
 	PLL_36XX_RATE(144000000,  96, 2, 3,     0),
-	PLL_36XX_RATE( 96000000, 128, 2, 4,     0),
-	PLL_36XX_RATE( 84000000, 112, 2, 4,     0),
-	PLL_36XX_RATE( 80000004, 106, 2, 4, 43691),
-	PLL_36XX_RATE( 73728000,  98, 2, 4, 19923),
-	PLL_36XX_RATE( 67737598, 270, 3, 5, 62285),
-	PLL_36XX_RATE( 65535999, 174, 2, 5, 49982),
-	PLL_36XX_RATE( 50000000, 200, 3, 5,     0),
-	PLL_36XX_RATE( 49152002, 131, 2, 5,  4719),
-	PLL_36XX_RATE( 48000000, 128, 2, 5,     0),
-	PLL_36XX_RATE( 45158401, 180, 3, 5, 41524),
+	PLL_36XX_RATE(96000000,  128, 2, 4,     0),
+	PLL_36XX_RATE(84000000,  112, 2, 4,     0),
+	PLL_36XX_RATE(80000004,  106, 2, 4, 43691),
+	PLL_36XX_RATE(73728000,   98, 2, 4, 19923),
+	PLL_36XX_RATE(67737598,  270, 3, 5, 62285),
+	PLL_36XX_RATE(65535999,  174, 2, 5, 49982),
+	PLL_36XX_RATE(50000000,  200, 3, 5,     0),
+	PLL_36XX_RATE(49152002,  131, 2, 5,  4719),
+	PLL_36XX_RATE(48000000,  128, 2, 5,     0),
+	PLL_36XX_RATE(45158401,  180, 3, 5, 41524),
 	{ /* sentinel */ }
 };
 
@@ -733,10 +743,10 @@ static const struct samsung_pll_rate_table exynos3250_vpll_rates[] __initconst =
 	PLL_36XX_RATE(148500000,  99, 2, 3,     0),
 	PLL_36XX_RATE(148352005,  98, 2, 3, 59070),
 	PLL_36XX_RATE(108000000, 144, 2, 4,     0),
-	PLL_36XX_RATE( 74250000,  99, 2, 4,     0),
-	PLL_36XX_RATE( 74176002,  98, 3, 4, 59070),
-	PLL_36XX_RATE( 54054000, 216, 3, 5, 14156),
-	PLL_36XX_RATE( 54000000, 144, 2, 5,     0),
+	PLL_36XX_RATE(74250000,   99, 2, 4,     0),
+	PLL_36XX_RATE(74176002,   98, 3, 4, 59070),
+	PLL_36XX_RATE(54054000,  216, 3, 5, 14156),
+	PLL_36XX_RATE(54000000,  144, 2, 5,     0),
 	{ /* sentinel */ }
 };
 
@@ -1098,4 +1108,3 @@ static int __init exynos3250_cmu_platform_init(void)
 					exynos3250_cmu_isp_probe);
 }
 subsys_initcall(exynos3250_cmu_platform_init);
-
-- 
1.9.1
