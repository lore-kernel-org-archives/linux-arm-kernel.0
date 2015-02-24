From: ideal.song@samsung.com (Inha Song)
Date: Tue, 24 Feb 2015 18:22:31 +0900
Subject: [PATCH] clk: samsung: Add CLKOUT driver support for Exynos3250 SoC.
Message-ID: <1424769751-4633-1-git-send-email-ideal.song@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add CLKOUT driver support for Exynos3250 SoC.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 3a7cb25..1c02e73 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -142,6 +142,8 @@ CLK_OF_DECLARE(exynos4212_clkout, "samsung,exynos4212-pmu",
 		exynos4_clkout_init);
 CLK_OF_DECLARE(exynos4412_clkout, "samsung,exynos4412-pmu",
 		exynos4_clkout_init);
+CLK_OF_DECLARE(exynos3250_clkout, "samsung,exynos3250-pmu",
+		exynos4_clkout_init);
 
 static void __init exynos5_clkout_init(struct device_node *node)
 {
-- 
2.0.0.390.gcb682f8
