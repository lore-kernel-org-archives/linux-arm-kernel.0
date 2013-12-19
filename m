From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 19 Dec 2013 18:14:36 +0200
Subject: [PATCH] clk: tegra: Add missing Tegra20 fuse clks
Message-ID: <1387469676-17693-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra20.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index b3b7204..4bc1cc5 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -575,6 +575,8 @@ static struct tegra_clk tegra20_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_tvdac] = { .dt_id = TEGRA20_CLK_TVDAC, .present = true },
 	[tegra_clk_vi_sensor] = { .dt_id = TEGRA20_CLK_VI_SENSOR, .present = true },
 	[tegra_clk_afi] = { .dt_id = TEGRA20_CLK_AFI, .present = true },
+	[tegra_clk_fuse] = { .dt_id = TEGRA20_CLK_FUSE, .present = true },
+	[tegra_clk_kfuse] = { .dt_id = TEGRA20_CLK_KFUSE, .present = true },
 };
 
 static unsigned long tegra20_clk_measure_input_freq(void)
-- 
1.7.7.rc0.72.g4b5ea.dirty
