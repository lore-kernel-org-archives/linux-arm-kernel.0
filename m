From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:33 +0000
Subject: [PATCH 5/5] ARM: qcom_defconfig: enable thermal sensors
In-Reply-To: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536933-21503-6-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables thermal sensors and QFPROM support for qcom platforms.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index f3d1114..f9d05fc 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -125,6 +125,7 @@ CONFIG_CHARGER_QCOM_SMBB=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_THERMAL=y
+CONFIG_QCOM_TSENS=y
 CONFIG_MFD_PM8XXX=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
@@ -187,6 +188,8 @@ CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_QCOM_IPQ806X_SATA=y
+CONFIG_NVMEM=y
+CONFIG_QCOM_QFPROM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-- 
2.10.1
