From: agross@codeaurora.org (Andy Gross)
Date: Tue,  8 Sep 2015 16:40:39 -0500
Subject: [PATCH] ARM: qcom_defconfig: Enable SMD-RPM regulators
Message-ID: <1441748439-26639-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables all of the options required to support SMD RPM based
regulators.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index ff7985b..ee54a70 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -109,6 +109,7 @@ CONFIG_MFD_QCOM_RPM=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_RPM=y
+CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_FB=y
 CONFIG_SOUND=y
@@ -145,16 +146,17 @@ CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_LCC_8960=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-CONFIG_MSM_IOMMU=y
+CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
+CONFIG_QCOM_SMD=y
+CONFIG_QCOM_SMD_RPM=y
+CONFIG_QCOM_SMEM=y
 CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_QCOM_IPQ806X_SATA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_EXT4_FS=y
 CONFIG_FUSE_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
