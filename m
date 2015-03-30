From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 30 Mar 2015 16:40:13 +0200
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable Tegra ACTMON support
Message-ID: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This brings the DevFreq framework in and builds the ACTMON driver that
on Tegra124 will scale the external memory clock based on current load.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ac96ce1..8e174ea 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -533,6 +533,8 @@ CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
+CONFIG_PM_DEVFREQ=y
+CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
-- 
2.1.0
