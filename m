From: aford173@gmail.com (Adam Ford)
Date: Fri,  8 Sep 2017 23:58:54 -0500
Subject: [RFC 1/2] configs: davinci_all_defconfig: Enable Backlight PWM module
Message-ID: <1504933135-29747-1-git-send-email-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850evm had an LCD that used ecap2 as the PWM brightness

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 06e2e2a..e97c728 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -146,6 +146,7 @@ CONFIG_DRM_DUMB_VGA_DAC=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_DA8XX=y
+CONFIG_BACKLIGHT_PWM=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
@@ -193,7 +194,6 @@ CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_USB_CDC_COMPOSITE=m
 CONFIG_MMC=y
-# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_DAVINCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
-- 
2.7.4
