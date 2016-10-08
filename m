From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat,  8 Oct 2016 13:52:31 +0100
Subject: [PATCH v10 09/11] ARM: multi_v7_defconfig: Enable st_remoteproc
 driver.
In-Reply-To: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
References: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1475931154-1021-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The st231 remote coprocessors are found on all STi chipsets.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c94611c..33f7a8a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -818,6 +818,7 @@ CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_REMOTEPROC=m
+CONFIG_ST_REMOTEPROC=m
 CONFIG_PM_DEVFREQ=y
 CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_MEMORY=y
-- 
1.9.1
