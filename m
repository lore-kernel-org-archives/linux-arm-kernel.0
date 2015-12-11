From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 11 Dec 2015 11:45:26 +0100
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Enable missing Renesas ARM
 support based on DTSes
In-Reply-To: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
References: <1449830727-325-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1449830727-325-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all missing support, extracted from the various Renesas ARM DTSes
using linux-config-from-dt.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e0fb5f34c0aca450..3d3c2b8522a23a93 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -152,6 +152,7 @@ CONFIG_CAN_RAW=y
 CONFIG_CAN_BCM=y
 CONFIG_CAN_DEV=y
 CONFIG_CAN_AT91=m
+CONFIG_CAN_RCAR=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
 CONFIG_CAN_SUN4I=y
@@ -304,6 +305,7 @@ CONFIG_I2C_AT91=m
 CONFIG_I2C_CADENCE=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_DIGICOLOR=m
+CONFIG_I2C_EMEV2=m
 CONFIG_I2C_GPIO=m
 CONFIG_I2C_EXYNOS5=y
 CONFIG_I2C_MV64XXX=y
@@ -384,6 +386,7 @@ CONFIG_EXYNOS_THERMAL=m
 CONFIG_ST_THERMAL_SYSCFG=y
 CONFIG_ST_THERMAL_MEMMAP=y
 CONFIG_WATCHDOG=y
+CONFIG_DA9063_WATCHDOG=m
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
@@ -400,6 +403,7 @@ CONFIG_MFD_AXP20X=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=y
+CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
@@ -457,6 +461,7 @@ CONFIG_SOC_CAMERA=m
 CONFIG_SOC_CAMERA_PLATFORM=m
 CONFIG_VIDEO_RCAR_VIN=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_JPU=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=m
@@ -611,6 +616,7 @@ CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_S35390A=m
 CONFIG_RTC_DRV_RX8581=m
 CONFIG_RTC_DRV_EM3027=y
+CONFIG_RTC_DRV_DA9063=m
 CONFIG_RTC_DRV_DIGICOLOR=m
 CONFIG_RTC_DRV_S5M=m
 CONFIG_RTC_DRV_S3C=m
@@ -630,6 +636,7 @@ CONFIG_MV_XOR=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
+CONFIG_RENESAS_USB_DMAC=m
 CONFIG_STE_DMA40=y
 CONFIG_SIRF_DMA=y
 CONFIG_TI_EDMA=y
-- 
1.9.1
