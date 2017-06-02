From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  2 Jun 2017 18:51:56 +0800
Subject: [PATCH v3 6/6] arm64: defconfig: enable support hi6421v530 PMIC
In-Reply-To: <20170602105156.11351-1-guodong.xu@linaro.org>
References: <20170602105156.11351-1-guodong.xu@linaro.org>
Message-ID: <20170602105156.11351-7-guodong.xu@linaro.org>
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
index ce07285..867d68c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -305,6 +305,7 @@ CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
 CONFIG_MFD_EXYNOS_LPASS=m
+CONFIG_MFD_HI6421_PMIC=y
 CONFIG_MFD_MAX77620=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SPMI_PMIC=y
@@ -315,6 +316,7 @@ CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_PWM=y
-- 
2.10.2
