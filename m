From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:35:57 +0200
Subject: [PATCH 2/9] ARM: tegra: fix hda2codec_2x clock name for Tegra30
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <4c052b5a83e74b1571409a0a2cee1cc2832095c2.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 drivers/clk/tegra/clk-tegra30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 4b9d8bd..3d14ea5 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -679,7 +679,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .dev_id = "tegra30-dam.1", .dt_id = TEGRA30_CLK_DAM1 },
 	{ .dev_id = "tegra30-dam.2", .dt_id = TEGRA30_CLK_DAM2 },
 	{ .con_id = "hda", .dev_id = "tegra30-hda", .dt_id = TEGRA30_CLK_HDA },
-	{ .con_id = "hda2codec", .dev_id = "tegra30-hda", .dt_id = TEGRA30_CLK_HDA2CODEC_2X },
+	{ .con_id = "hda2codec_2x", .dev_id = "tegra30-hda", .dt_id = TEGRA30_CLK_HDA2CODEC_2X },
 	{ .dev_id = "spi_tegra.0", .dt_id = TEGRA30_CLK_SBC1 },
 	{ .dev_id = "spi_tegra.1", .dt_id = TEGRA30_CLK_SBC2 },
 	{ .dev_id = "spi_tegra.2", .dt_id = TEGRA30_CLK_SBC3 },
-- 
1.9.3
