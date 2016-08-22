From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 18:48:39 +0900
Subject: [PATCH 5/5] clk: samsung: exynos4: Fix the checkpatch warnings
In-Reply-To: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
References: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471859319-30681-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following warnings by using checkpatch.pl script.
- Remove the space prohibited after that open parenthesis '('
- Remove the unneeded blank line

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 51 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index faab9b31baf5..9809e6d8dadd 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1267,13 +1267,13 @@ static const struct of_device_id ext_clk_match[] __initconst = {
 static const struct samsung_pll_rate_table exynos4210_apll_rates[] __initconst = {
 	PLL_45XX_RATE(1200000000, 150,  3, 1, 28),
 	PLL_45XX_RATE(1000000000, 250,  6, 1, 28),
-	PLL_45XX_RATE( 800000000, 200,  6, 1, 28),
-	PLL_45XX_RATE( 666857142, 389, 14, 1, 13),
-	PLL_45XX_RATE( 600000000, 100,  4, 1, 13),
-	PLL_45XX_RATE( 533000000, 533, 24, 1,  5),
-	PLL_45XX_RATE( 500000000, 250,  6, 2, 28),
-	PLL_45XX_RATE( 400000000, 200,  6, 2, 28),
-	PLL_45XX_RATE( 200000000, 200,  6, 3, 28),
+	PLL_45XX_RATE(800000000,  200,  6, 1, 28),
+	PLL_45XX_RATE(666857142,  389, 14, 1, 13),
+	PLL_45XX_RATE(600000000,  100,  4, 1, 13),
+	PLL_45XX_RATE(533000000,  533, 24, 1,  5),
+	PLL_45XX_RATE(500000000,  250,  6, 2, 28),
+	PLL_45XX_RATE(400000000,  200,  6, 2, 28),
+	PLL_45XX_RATE(200000000,  200,  6, 3, 28),
 	{ /* sentinel */ }
 };
 
@@ -1281,10 +1281,10 @@ static const struct samsung_pll_rate_table exynos4210_epll_rates[] __initconst =
 	PLL_4600_RATE(192000000, 48, 3, 1,     0, 0),
 	PLL_4600_RATE(180633605, 45, 3, 1, 10381, 0),
 	PLL_4600_RATE(180000000, 45, 3, 1,     0, 0),
-	PLL_4600_RATE( 73727996, 73, 3, 3, 47710, 1),
-	PLL_4600_RATE( 67737602, 90, 4, 3, 20762, 1),
-	PLL_4600_RATE( 49151992, 49, 3, 3,  9961, 0),
-	PLL_4600_RATE( 45158401, 45, 3, 3, 10381, 0),
+	PLL_4600_RATE(73727996,  73, 3, 3, 47710, 1),
+	PLL_4600_RATE(67737602,  90, 4, 3, 20762, 1),
+	PLL_4600_RATE(49151992,  49, 3, 3,  9961, 0),
+	PLL_4600_RATE(45158401,  45, 3, 3, 10381, 0),
 	{ /* sentinel */ }
 };
 
@@ -1293,7 +1293,7 @@ static const struct samsung_pll_rate_table exynos4210_vpll_rates[] __initconst =
 	PLL_4650_RATE(324000000, 53, 2, 1, 1024, 1,  1, 1),
 	PLL_4650_RATE(259617187, 63, 3, 1, 1950, 0, 20, 1),
 	PLL_4650_RATE(110000000, 53, 3, 2, 2048, 0, 17, 0),
-	PLL_4650_RATE( 55360351, 53, 3, 3, 2417, 0, 17, 0),
+	PLL_4650_RATE(55360351,  53, 3, 3, 2417, 0, 17, 0),
 	{ /* sentinel */ }
 };
 
@@ -1304,14 +1304,14 @@ static const struct samsung_pll_rate_table exynos4x12_apll_rates[] __initconst =
 	PLL_35XX_RATE(1200000000, 200, 4, 0),
 	PLL_35XX_RATE(1100000000, 275, 6, 0),
 	PLL_35XX_RATE(1000000000, 125, 3, 0),
-	PLL_35XX_RATE( 900000000, 150, 4, 0),
-	PLL_35XX_RATE( 800000000, 100, 3, 0),
-	PLL_35XX_RATE( 700000000, 175, 3, 1),
-	PLL_35XX_RATE( 600000000, 200, 4, 1),
-	PLL_35XX_RATE( 500000000, 125, 3, 1),
-	PLL_35XX_RATE( 400000000, 100, 3, 1),
-	PLL_35XX_RATE( 300000000, 200, 4, 2),
-	PLL_35XX_RATE( 200000000, 100, 3, 2),
+	PLL_35XX_RATE(900000000,  150, 4, 0),
+	PLL_35XX_RATE(800000000,  100, 3, 0),
+	PLL_35XX_RATE(700000000,  175, 3, 1),
+	PLL_35XX_RATE(600000000,  200, 4, 1),
+	PLL_35XX_RATE(500000000,  125, 3, 1),
+	PLL_35XX_RATE(400000000,  100, 3, 1),
+	PLL_35XX_RATE(300000000,  200, 4, 2),
+	PLL_35XX_RATE(200000000,  100, 3, 2),
 	{ /* sentinel */ }
 };
 
@@ -1319,10 +1319,10 @@ static const struct samsung_pll_rate_table exynos4x12_epll_rates[] __initconst =
 	PLL_36XX_RATE(192000000, 48, 3, 1,     0),
 	PLL_36XX_RATE(180633605, 45, 3, 1, 10381),
 	PLL_36XX_RATE(180000000, 45, 3, 1,     0),
-	PLL_36XX_RATE( 73727996, 73, 3, 3, 47710),
-	PLL_36XX_RATE( 67737602, 90, 4, 3, 20762),
-	PLL_36XX_RATE( 49151992, 49, 3, 3,  9961),
-	PLL_36XX_RATE( 45158401, 45, 3, 3, 10381),
+	PLL_36XX_RATE(73727996,  73, 3, 3, 47710),
+	PLL_36XX_RATE(67737602,  90, 4, 3, 20762),
+	PLL_36XX_RATE(49151992,  49, 3, 3,  9961),
+	PLL_36XX_RATE(45158401,  45, 3, 3, 10381),
 	{ /* sentinel */ }
 };
 
@@ -1333,7 +1333,7 @@ static const struct samsung_pll_rate_table exynos4x12_vpll_rates[] __initconst =
 	PLL_36XX_RATE(266000000, 133, 3, 2,     0),
 	PLL_36XX_RATE(160000000, 160, 3, 3,     0),
 	PLL_36XX_RATE(106031250,  53, 3, 2,  1024),
-	PLL_36XX_RATE( 53015625,  53, 3, 3,  1024),
+	PLL_36XX_RATE(53015625,   53, 3, 3,  1024),
 	{ /* sentinel */ }
 };
 
@@ -1559,7 +1559,6 @@ static void __init exynos4_clk_init(struct device_node *np,
 		_get_rate("div_core2"));
 }
 
-
 static void __init exynos4210_clk_init(struct device_node *np)
 {
 	exynos4_clk_init(np, EXYNOS4210);
-- 
1.9.1
