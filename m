From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 18:48:35 +0900
Subject: [PATCH 1/5] clk: samsung: exynos5433: Fix the checkpatch warnings
In-Reply-To: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
References: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471859319-30681-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the line over 80 characters by using checkpatch.pl script.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index ea1608682d7f..6842d3833f1e 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -1826,11 +1826,13 @@ static const struct samsung_gate_clock peris_gate_clks[] __initconst = {
 
 	/* ENABLE_PCLK_PERIS_SECURE_SECKEY_APBIF */
 	GATE(CLK_PCLK_SECKEY_APBIF, "pclk_seckey_apbif", "aclk_peris_66",
-			ENABLE_PCLK_PERIS_SECURE_SECKEY_APBIF, 0, CLK_IGNORE_UNUSED, 0),
+			ENABLE_PCLK_PERIS_SECURE_SECKEY_APBIF, 0,
+			CLK_IGNORE_UNUSED, 0),
 
 	/* ENABLE_PCLK_PERIS_SECURE_CHIPID_APBIF */
 	GATE(CLK_PCLK_CHIPID_APBIF, "pclk_chipid_apbif", "aclk_peris_66",
-			ENABLE_PCLK_PERIS_SECURE_CHIPID_APBIF, 0, CLK_IGNORE_UNUSED, 0),
+			ENABLE_PCLK_PERIS_SECURE_CHIPID_APBIF, 0,
+			CLK_IGNORE_UNUSED, 0),
 
 	/* ENABLE_PCLK_PERIS_SECURE_TOPRTC */
 	GATE(CLK_PCLK_TOPRTC, "pclk_toprtc", "aclk_peris_66",
-- 
1.9.1
