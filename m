From: absahu@codeaurora.org (Abhishek Sahu)
Date: Fri, 28 Apr 2017 15:57:53 +0530
Subject: [PATCH] ARM: qcom_defconfig: Enable IPQ4019 clock and pinctrl
Message-ID: <1493375273-1635-1-git-send-email-absahu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These configs are required for booting kernel in QCOM IPQ4019 boards.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 4ffdd60..28c98c6 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -113,6 +113,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
+CONFIG_PINCTRL_IPQ4019=y
 CONFIG_PINCTRL_IPQ8064=y
 CONFIG_PINCTRL_MSM8660=y
 CONFIG_PINCTRL_MSM8960=y
@@ -182,6 +183,7 @@ CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_RPM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_APQ_MMCC_8084=y
+CONFIG_IPQ_GCC_4019=y
 CONFIG_IPQ_LCC_806X=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_LCC_8960=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
