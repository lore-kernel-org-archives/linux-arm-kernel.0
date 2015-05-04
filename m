From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:42 +0200
Subject: [PATCH 4/8] soc/tegra: Add Tegra210 support
In-Reply-To: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
References: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1430740006-29539-5-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add Tegra210 to the matching table for NVIDIA Tegra SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index a952986a14b7..cd8f41351add 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -16,6 +16,7 @@ static const struct of_device_id tegra_machine_match[] = {
 	{ .compatible = "nvidia,tegra114", },
 	{ .compatible = "nvidia,tegra124", },
 	{ .compatible = "nvidia,tegra132", },
+	{ .compatible = "nvidia,tegra210", },
 	{ }
 };
 
-- 
2.3.5
