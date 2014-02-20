From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 20 Feb 2014 15:54:07 +0200
Subject: [PATCH] clk: tegra124: remove gr2d and gr3d clocks
Message-ID: <1392904448-11939-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra124 does not have gr2d and gr3d clocks. They have been replaced by the
vic03 and gpu clocks respectively.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index b4cf650..166e02f 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -769,10 +769,8 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_sdmmc4_8] = { .dt_id = TEGRA124_CLK_SDMMC4, .present = true },
 	[tegra_clk_pwm] = { .dt_id = TEGRA124_CLK_PWM, .present = true },
 	[tegra_clk_i2s2] = { .dt_id = TEGRA124_CLK_I2S2, .present = true },
-	[tegra_clk_gr2d] = { .dt_id = TEGRA124_CLK_GR_2D, .present = true },
 	[tegra_clk_usbd] = { .dt_id = TEGRA124_CLK_USBD, .present = true },
 	[tegra_clk_isp_8] = { .dt_id = TEGRA124_CLK_ISP, .present = true },
-	[tegra_clk_gr3d] = { .dt_id = TEGRA124_CLK_GR_3D, .present = true },
 	[tegra_clk_disp2] = { .dt_id = TEGRA124_CLK_DISP2, .present = true },
 	[tegra_clk_disp1] = { .dt_id = TEGRA124_CLK_DISP1, .present = true },
 	[tegra_clk_host1x_8] = { .dt_id = TEGRA124_CLK_HOST1X, .present = true },
-- 
1.7.7.rc0.72.g4b5ea.dirty
