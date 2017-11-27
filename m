From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Mon, 27 Nov 2017 11:44:58 +0000
Subject: [PATCH 3/3] ARM: qcom_defconfig: Enable Frambuffer console support
In-Reply-To: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
References: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
Message-ID: <20171127114458.20976-4-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds framebuffer console support to qcom defconfig.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 237aa79339f6..dd2a089f939f 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -138,6 +138,7 @@ CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_DRM=y
 CONFIG_FB=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-- 
2.15.0
