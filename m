From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Mon, 27 Nov 2017 11:44:56 +0000
Subject: [PATCH 1/3] ARM: qcom_defconfig: Enable DRM for 8064 display
In-Reply-To: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
References: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
Message-ID: <20171127114458.20976-2-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This enables DRM Kconfig for apq8064 display.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index c784d04e2ab7..8a340c316a9a 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -136,6 +136,7 @@ CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_MEDIA_SUPPORT=y
+CONFIG_DRM=y
 CONFIG_FB=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
2.15.0
