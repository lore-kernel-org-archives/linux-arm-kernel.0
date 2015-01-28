From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Jan 2015 13:38:01 -0800
Subject: [PATCH 1/2] arm: qcom_defconfig: Enable lpass clock driver
Message-ID: <1422481082-4821-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Enable the LPASS clock controller driver so that audio drivers
can enable, disable, and set rates on their clocks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
[sboyd at codeaurora.org: Enable 8960 driver too]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c7da3319d82..881d18b9b4de 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -138,7 +138,9 @@ CONFIG_QCOM_GSBI=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_GCC_806X=y
+CONFIG_IPQ_LCC_806X=y
 CONFIG_MSM_GCC_8660=y
+CONFIG_MSM_LCC_8960=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_MSM_IOMMU=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
