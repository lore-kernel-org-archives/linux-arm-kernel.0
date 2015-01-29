From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 29 Jan 2015 15:09:16 +0100
Subject: [PATCH v6 8/8] ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen
 controller and ADC support.
In-Reply-To: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1422540556-14828-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Denis Carikli <denis@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/configs/imx_v4_v5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index e6b0007355f8..e1bda0136f6c 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -89,6 +89,7 @@ CONFIG_KEYBOARD_IMX=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_TOUCHSCREEN_MX25=y
 CONFIG_TOUCHSCREEN_MC13783=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=m
@@ -108,6 +109,7 @@ CONFIG_HWMON=m
 CONFIG_SENSORS_MC13783_ADC=m
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
+CONFIG_MFD_MX25_TSADC=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -173,6 +175,8 @@ CONFIG_DMADEVICES=y
 CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_FSL_MX25_ADC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
-- 
2.1.4
