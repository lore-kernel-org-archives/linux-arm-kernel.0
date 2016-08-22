From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 18:48:37 +0900
Subject: [PATCH 3/5] clk: samsung: exynos5260: Fix the checkpatch warnings
In-Reply-To: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
References: <1471859319-30681-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471859319-30681-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the the prohibited space by using checkscript.pl script.
- ERROR: space prohibited before that ','

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5260.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index fd1d9bfc151b..e613b03f1acd 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -1446,7 +1446,7 @@ static const struct samsung_fixed_rate_clock fixed_rate_clks[] __initconst = {
 	FRATE(PHYCLK_HDMI_LINK_O_TMDS_CLKHI, "phyclk_hdmi_link_o_tmds_clkhi",
 			NULL, 0, 125000000),
 	FRATE(PHYCLK_MIPI_DPHY_4L_M_TXBYTECLKHS,
-			"phyclk_mipi_dphy_4l_m_txbyte_clkhs" , NULL,
+			"phyclk_mipi_dphy_4l_m_txbyte_clkhs", NULL,
 			0, 187500000),
 	FRATE(PHYCLK_DPTX_PHY_O_REF_CLK_24M, "phyclk_dptx_phy_o_ref_clk_24m",
 			NULL, 0, 24000000),
@@ -1617,7 +1617,7 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
 			mout_isp1_media_400_p,
 			MUX_SEL_TOP_ISP10, 4, 1),
 	MUX(TOP_MOUT_ACLK_ISP1_400, "mout_aclk_isp1_400", mout_aclk_isp1_400_p,
-			MUX_SEL_TOP_ISP10, 8 , 1),
+			MUX_SEL_TOP_ISP10, 8, 1),
 	MUX(TOP_MOUT_ISP1_MEDIA_266, "mout_isp1_media_266",
 			mout_isp1_media_266_p,
 			MUX_SEL_TOP_ISP10, 16, 1),
-- 
1.9.1
