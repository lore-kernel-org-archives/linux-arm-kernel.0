From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed,  4 Oct 2017 11:58:56 -0700
Subject: [PATCH 3/4] ARM: qcom_defconfig: Disable DEBUG_GPIO
In-Reply-To: <20171004185857.24510-1-bjorn.andersson@linaro.org>
References: <20171004185857.24510-1-bjorn.andersson@linaro.org>
Message-ID: <20171004185857.24510-4-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO debug spams the kernel log quite a bit, so remove this from the
default Qualcomm defconfig.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 82cd86e524a4..f6aa100bf69c 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -115,7 +115,6 @@ CONFIG_PINCTRL_MSM8X74=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIOLIB=y
-CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
-- 
2.12.0
