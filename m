From: mirza.krak@gmail.com (Mirza Krak)
Date: Wed, 24 Aug 2016 15:37:13 +0200
Subject: [PATCH v2 1/6] clk: tegra: add TEGRA20_CLK_NOR to init table
In-Reply-To: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
References: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
Message-ID: <1472045838-22628-2-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Add TEGRA20_CLK_NOR to init tabel and set default rate to 92 MHz which
is max rate.

Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
---
Changes in v2:
- no changes

 drivers/clk/tegra/clk-tegra20.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 837e5cb..13d3b5a 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1047,6 +1047,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_SDMMC3, TEGRA20_CLK_PLL_P, 48000000, 0 },
 	{ TEGRA20_CLK_SDMMC4, TEGRA20_CLK_PLL_P, 48000000, 0 },
 	{ TEGRA20_CLK_SPI, TEGRA20_CLK_PLL_P, 20000000, 0 },
+	{ TEGRA20_CLK_NOR, TEGRA20_CLK_PLL_P, 92000000, 0 },
 	{ TEGRA20_CLK_SBC1, TEGRA20_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA20_CLK_SBC2, TEGRA20_CLK_PLL_P, 100000000, 0 },
 	{ TEGRA20_CLK_SBC3, TEGRA20_CLK_PLL_P, 100000000, 0 },
--
2.1.4
