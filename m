From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 15 Jan 2014 15:31:10 +0530
Subject: [PATCH 2/2] clk: exynos4: Fix spacing related checkpatch errors
In-Reply-To: <1389780070-4959-1-git-send-email-sachin.kamat@linaro.org>
References: <1389780070-4959-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1389780070-4959-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silences the following type of checkpatch errors:
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos4.c |   50 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 12a9f28f9f17..3f412b4ef3e3 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -945,13 +945,13 @@ static struct of_device_id ext_clk_match[] __initdata = {
 static struct samsung_pll_rate_table exynos4210_apll_rates[] __initdata = {
 	PLL_45XX_RATE(1200000000, 150,  3, 1, 28),
 	PLL_45XX_RATE(1000000000, 250,  6, 1, 28),
-	PLL_45XX_RATE( 800000000, 200,  6, 1, 28),
-	PLL_45XX_RATE( 666857142, 389, 14, 1, 13),
-	PLL_45XX_RATE( 600000000, 100,  4, 1, 13),
-	PLL_45XX_RATE( 533000000, 533, 24, 1,  5),
-	PLL_45XX_RATE( 500000000, 250,  6, 2, 28),
-	PLL_45XX_RATE( 400000000, 200,  6, 2, 28),
-	PLL_45XX_RATE( 200000000, 200,  6, 3, 28),
+	PLL_45XX_RATE(800000000, 200,  6, 1, 28),
+	PLL_45XX_RATE(666857142, 389, 14, 1, 13),
+	PLL_45XX_RATE(600000000, 100,  4, 1, 13),
+	PLL_45XX_RATE(533000000, 533, 24, 1,  5),
+	PLL_45XX_RATE(500000000, 250,  6, 2, 28),
+	PLL_45XX_RATE(400000000, 200,  6, 2, 28),
+	PLL_45XX_RATE(200000000, 200,  6, 3, 28),
 	{ /* sentinel */ }
 };
 
@@ -959,10 +959,10 @@ static struct samsung_pll_rate_table exynos4210_epll_rates[] __initdata = {
 	PLL_4600_RATE(192000000, 48, 3, 1,     0, 0),
 	PLL_4600_RATE(180633605, 45, 3, 1, 10381, 0),
 	PLL_4600_RATE(180000000, 45, 3, 1,     0, 0),
-	PLL_4600_RATE( 73727996, 73, 3, 3, 47710, 1),
-	PLL_4600_RATE( 67737602, 90, 4, 3, 20762, 1),
-	PLL_4600_RATE( 49151992, 49, 3, 3,  9961, 0),
-	PLL_4600_RATE( 45158401, 45, 3, 3, 10381, 0),
+	PLL_4600_RATE(73727996, 73, 3, 3, 47710, 1),
+	PLL_4600_RATE(67737602, 90, 4, 3, 20762, 1),
+	PLL_4600_RATE(49151992, 49, 3, 3,  9961, 0),
+	PLL_4600_RATE(45158401, 45, 3, 3, 10381, 0),
 	{ /* sentinel */ }
 };
 
@@ -971,7 +971,7 @@ static struct samsung_pll_rate_table exynos4210_vpll_rates[] __initdata = {
 	PLL_4650_RATE(324000000, 53, 2, 1, 1024, 1,  1, 1),
 	PLL_4650_RATE(259617187, 63, 3, 1, 1950, 0, 20, 1),
 	PLL_4650_RATE(110000000, 53, 3, 2, 2048, 0, 17, 0),
-	PLL_4650_RATE( 55360351, 53, 3, 3, 2417, 0, 17, 0),
+	PLL_4650_RATE(55360351, 53, 3, 3, 2417, 0, 17, 0),
 	{ /* sentinel */ }
 };
 
@@ -982,14 +982,14 @@ static struct samsung_pll_rate_table exynos4x12_apll_rates[] __initdata = {
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
+	PLL_35XX_RATE(900000000, 150, 4, 0),
+	PLL_35XX_RATE(800000000, 100, 3, 0),
+	PLL_35XX_RATE(700000000, 175, 3, 1),
+	PLL_35XX_RATE(600000000, 200, 4, 1),
+	PLL_35XX_RATE(500000000, 125, 3, 1),
+	PLL_35XX_RATE(400000000, 100, 3, 1),
+	PLL_35XX_RATE(300000000, 200, 4, 2),
+	PLL_35XX_RATE(200000000, 100, 3, 2),
 	{ /* sentinel */ }
 };
 
@@ -997,10 +997,10 @@ static struct samsung_pll_rate_table exynos4x12_epll_rates[] __initdata = {
 	PLL_36XX_RATE(192000000, 48, 3, 1,     0),
 	PLL_36XX_RATE(180633605, 45, 3, 1, 10381),
 	PLL_36XX_RATE(180000000, 45, 3, 1,     0),
-	PLL_36XX_RATE( 73727996, 73, 3, 3, 47710),
-	PLL_36XX_RATE( 67737602, 90, 4, 3, 20762),
-	PLL_36XX_RATE( 49151992, 49, 3, 3,  9961),
-	PLL_36XX_RATE( 45158401, 45, 3, 3, 10381),
+	PLL_36XX_RATE(73727996, 73, 3, 3, 47710),
+	PLL_36XX_RATE(67737602, 90, 4, 3, 20762),
+	PLL_36XX_RATE(49151992, 49, 3, 3,  9961),
+	PLL_36XX_RATE(45158401, 45, 3, 3, 10381),
 	{ /* sentinel */ }
 };
 
@@ -1011,7 +1011,7 @@ static struct samsung_pll_rate_table exynos4x12_vpll_rates[] __initdata = {
 	PLL_36XX_RATE(266000000, 133, 3, 2,     0),
 	PLL_36XX_RATE(160000000, 160, 3, 3,     0),
 	PLL_36XX_RATE(106031250,  53, 3, 2,  1024),
-	PLL_36XX_RATE( 53015625,  53, 3, 3,  1024),
+	PLL_36XX_RATE(53015625,  53, 3, 3,  1024),
 	{ /* sentinel */ }
 };
 
-- 
1.7.9.5
