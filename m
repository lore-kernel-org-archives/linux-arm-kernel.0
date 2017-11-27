From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Mon, 27 Nov 2017 11:44:57 +0000
Subject: [PATCH 2/3] ARM: qcom_defconfig: enable MSM IOMMU for display
In-Reply-To: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
References: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
Message-ID: <20171127114458.20976-3-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

MSM IOMMU is required for apq8064 display, so enable it by default.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8a340c316a9a..237aa79339f6 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -201,6 +201,7 @@ CONFIG_MSM_LCC_8960=y
 CONFIG_MDM_LCC_9615=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
+CONFIG_MSM_IOMMU=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_REMOTEPROC=y
-- 
2.15.0
