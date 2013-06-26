From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:14 +0300
Subject: [PATCH 11/23] iommu/tegra: smmu: Add of_mach_id for T114
Message-ID: <1372238906-9346-12-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_mach_id for T114

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4c16c90..3e03c69 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1262,6 +1262,7 @@ const struct dev_pm_ops tegra_smmu_pm_ops = {
 };
 
 static struct of_device_id tegra_smmu_of_match[] = {
+	{ .compatible = "nvidia,tegra114-smmu", },
 	{ .compatible = "nvidia,tegra30-smmu", },
 	{ },
 };
-- 
1.8.1.5
