From: vdumpa@nvidia.com (Krishna Reddy)
Date: Wed, 31 Oct 2018 16:48:35 -0700
Subject: [PATCH v2 4/5] arm64: defconfig: Enable ARM_SMMU_TEGRA
In-Reply-To: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
References: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
Message-ID: <1541029716-14353-5-git-send-email-vdumpa@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling CONFIG_ARM_SMMU_TEGRA that is used
by Tegra194 SOC.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4b38444..d875f64 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -611,6 +611,7 @@ CONFIG_QCOM_APCS_IPC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
+CONFIG_ARM_SMMU_TEGRA=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
-- 
2.1.4
