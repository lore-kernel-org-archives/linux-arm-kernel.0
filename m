From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 18 Oct 2016 10:39:13 +0100
Subject: [PATCH v10 08/11] ARM: multi_v7_defconfig: Enable remoteproc core
In-Reply-To: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1476783556-2501-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that remoteproc core is selectable it needs to be enabled
in the multi_v7 build.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 437d074..538c326 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -823,6 +823,7 @@ CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
+CONFIG_REMOTEPROC=m
 CONFIG_PM_DEVFREQ=y
 CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_MEMORY=y
-- 
1.9.1
