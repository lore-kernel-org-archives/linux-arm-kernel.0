From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 10 Aug 2017 10:37:24 +0800
Subject: [PATCH v2 2/6] arm64: defconfig: enable support hi6421v530 PMIC
In-Reply-To: <20170810023728.19621-1-guodong.xu@linaro.org>
References: <20170810023728.19621-1-guodong.xu@linaro.org>
Message-ID: <20170810023728.19621-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable configs for hi6421v530 mfd and regulator driver
 + CONFIG_MFD_HI6421_PMIC=y
 + CONFIG_REGULATOR_HI6421V530=y

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4e14c6d..d752beb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -317,6 +317,7 @@ CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_EXYNOS_LPASS=m
+CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_HI655X_PMIC=y
 CONFIG_MFD_MAX77620=y
 CONFIG_MFD_SPMI_PMIC=y
@@ -325,6 +326,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_PWM=y
-- 
2.10.2
