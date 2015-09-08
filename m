From: agross@codeaurora.org (Andy Gross)
Date: Tue,  8 Sep 2015 16:41:18 -0500
Subject: [PATCH] ARM: multi_v7_defconfig: Enable QCOM SMD/RPM
Message-ID: <1441748478-26676-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables all of the options necessary to support the Qualcomm SMD
RPM regulator driver.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/configs/multi_v7_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 824a0cf..0a21629 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -412,6 +412,7 @@ CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PWM=m
+CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
@@ -616,6 +617,9 @@ CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
+CONFIG_QCOM_SMD=y
+CONFIG_QCOM_SMD_RPM=y
+CONFIG_QCOM_SMEM=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC_CHARDEV=m
@@ -626,6 +630,7 @@ CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
+CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_PM_DEVFREQ=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
