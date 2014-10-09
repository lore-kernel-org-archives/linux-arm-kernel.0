From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 09 Oct 2014 13:32:57 +0200
Subject: [PATCH 1/3] ARM: exynos_defconfig: Enable Maxim 77836 for Gear2 board
Message-ID: <1412854379-18875-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all Maxim 14577 drivers and Maxim 17040 fuel gauge driver to
support the Maxim 77836 PMIC present on Samsung Rinato board (Gear 2).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index b14d8c3f7e12..ce600b654297 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -78,6 +78,8 @@ CONFIG_SPI_S3C64XX=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
+CONFIG_BATTERY_MAX17040=y
+CONFIG_CHARGER_MAX14577=y
 CONFIG_CHARGER_TPS65090=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
@@ -88,6 +90,7 @@ CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_MFD_CROS_EC_SPI=y
+CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
 CONFIG_MFD_MAX8997=y
@@ -95,6 +98,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_TPS65090=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MAX14577=y
 CONFIG_REGULATOR_MAX8997=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_MAX77693=y
@@ -140,6 +144,8 @@ CONFIG_PL330_DMA=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_EXYNOS_IOMMU=y
+CONFIG_EXTCON=y
+CONFIG_EXTCON_MAX14577=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_PWM=y
-- 
1.9.1
