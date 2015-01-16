From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Jan 2015 11:39:13 +0000 (UTC)
Subject: [PATCH] soc: tegra: Add Tegra132 SoC to the DT list of Tegra SoCs
Message-ID: <alpine.DEB.2.02.1501161137351.9776@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add "nvidia,tegra132" as a compatible string that denotes a Tegra SoC.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/soc/tegra/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index a71cb74..a952986 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -15,6 +15,7 @@ static const struct of_device_id tegra_machine_match[] = {
 	{ .compatible = "nvidia,tegra30", },
 	{ .compatible = "nvidia,tegra114", },
 	{ .compatible = "nvidia,tegra124", },
+	{ .compatible = "nvidia,tegra132", },
 	{ }
 };
 
-- 
2.0.0.GIT
