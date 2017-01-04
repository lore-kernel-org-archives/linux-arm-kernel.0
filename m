From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:29 +0000
Subject: [PATCH 1/5] ARM: qcom_defconfig: enable qcom rpm clk controller
In-Reply-To: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536933-21503-2-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rpm clock controller config is required for qcom scm driver, without
which the board fails to boot successfully.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c3a010..dc27e51 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -157,6 +157,7 @@ CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_STAGING=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_QCOM_CLK_RPM=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_LCC_806X=y
 CONFIG_MSM_GCC_8660=y
-- 
2.10.1
