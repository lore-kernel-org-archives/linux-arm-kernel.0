From: mirza.krak@gmail.com (Mirza Krak)
Date: Wed, 24 Aug 2016 15:37:14 +0200
Subject: [PATCH v2 2/6] clk: tegra: add TEGRA30_CLK_NOR to init table
In-Reply-To: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1472045838-22628-3-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Add TEGRA30_CLK_NOR to init table and set default rate to 127 MHz which
is max rate.

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
Changes in v2:
- no changes

 drivers/clk/tegra/clk-tegra30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 8e2db5e..67f1677 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1252,6 +1252,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_SDMMC1, TEGRA30_CLK_PLL_P, 48000000, 0 },
 	{ TEGRA30_CLK_SDMMC2, TEGRA30_CLK_PLL_P, 48000000, 0 },
 	{ TEGRA30_CLK_SDMMC3, TEGRA30_CLK_PLL_P, 48000000, 0 },
+	{ TEGRA30_CLK_NOR, TEGRA30_CLK_PLL_P, 127000000, 0 },
 	{ TEGRA30_CLK_PLL_M, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_PCLK, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_CSITE, TEGRA30_CLK_CLK_MAX, 0, 1 },
--
2.1.4
