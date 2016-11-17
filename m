From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Thu, 17 Nov 2016 17:20:26 +0200
Subject: [PATCH] ARM: qcom_defconfig: Enable RPM/RPM-SMD clocks
Message-ID: <20161117152026.10491-1-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for clocks, controlled by the RPM processor on
Qualcomm platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 9f6d2a69a6f7..553d0a5827f2 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -158,6 +158,8 @@ CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_STAGING=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_QCOM_CLK_RPM=y
+CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_LCC_806X=y
 CONFIG_MSM_GCC_8660=y
