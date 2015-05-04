From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:41 +0200
Subject: [PATCH 3/8] soc/tegra: Add Tegra132 support
In-Reply-To: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
References: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1430740006-29539-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add Tegra132 to the matching table for NVIDIA Tegra SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index a71cb74f3674..a952986a14b7 100644
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
2.3.5
