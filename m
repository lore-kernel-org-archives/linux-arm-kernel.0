From: voytikd@gmail.com (Dmitry Voytik)
Date: Thu,  6 Nov 2014 22:46:20 +0400
Subject: [PATCH] ARM: imx6q: drop unnecessary semicolon
Message-ID: <1415299580-20790-1-git-send-email-voytikd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop unnecessary semicolon after closing curly bracket.

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 arch/arm/mach-imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 1412daf..43f376f 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -145,7 +145,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		post_div_table[2].div = 1;
 		video_div_table[1].div = 1;
 		video_div_table[2].div = 1;
-	};
+	}
 
 	clk[IMX6QDL_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src", base + 0x00, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
 	clk[IMX6QDL_PLL2_BYPASS_SRC] = imx_clk_mux("pll2_bypass_src", base + 0x30, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-- 
1.9.1
