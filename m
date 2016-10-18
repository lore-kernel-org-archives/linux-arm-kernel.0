From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 18 Oct 2016 10:39:14 +0100
Subject: [PATCH v10 09/11] ARM: multi_v7_defconfig: Enable st_remoteproc
 driver.
In-Reply-To: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1476783556-2501-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The st231 remote coprocessors are found on all STi chipsets.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 538c326..0a06af9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -824,6 +824,7 @@ CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_REMOTEPROC=m
+CONFIG_ST_REMOTEPROC=m
 CONFIG_PM_DEVFREQ=y
 CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_MEMORY=y
-- 
1.9.1
