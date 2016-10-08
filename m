From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat,  8 Oct 2016 13:52:30 +0100
Subject: [PATCH v10 08/11] ARM: multi_v7_defconfig: Enable remoteproc core
In-Reply-To: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
References: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1475931154-1021-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that remoteproc core is selectable it needs to be enabled
in the multi_v7 build.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3ca4974..c94611c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -817,6 +817,7 @@ CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
+CONFIG_REMOTEPROC=m
 CONFIG_PM_DEVFREQ=y
 CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_MEMORY=y
-- 
1.9.1
