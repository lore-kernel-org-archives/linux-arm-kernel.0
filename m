From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jul 2015 19:18:19 +0200
Subject: [PATCH] ARM: at91: at91_dt_defconfig: enable ISI and ov2640 support
Message-ID: <1438276699-11861-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Add Atmel-isi and ov2640 driver in defconfig

Signed-off-by: Josh Wu <josh.wu@atmel.com>
[nicolas.ferre at atmel.com: make SOC_CAMERA_OV2640 selected as a module]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Arnd, Olof, Kevin,

This is the only "defconfig" patch that I have for now. Can you please take it
for 4.3?

Thanks, bye.
  Nicolas.

 arch/arm/configs/at91_dt_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 94b5dcabdecc..c7abc0d77da7 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -133,6 +133,12 @@ CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SSB=m
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_SOC_CAMERA_OV2640=m
 CONFIG_FB=y
 CONFIG_FB_ATMEL=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
2.1.3
