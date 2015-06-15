From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 15 Jun 2015 18:27:18 +0800
Subject: [PATCH 2/2] ARM: at91: at91_dt_defconfig: enable ISI and ov2640
 support
In-Reply-To: <1434364038-8117-1-git-send-email-josh.wu@atmel.com>
References: <1434364038-8117-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1434364038-8117-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Atmel-isi and ov2640 driver in defconfig

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/configs/at91_dt_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index bcef49a..d089ec9 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -131,6 +131,12 @@ CONFIG_POWER_RESET=y
 CONFIG_WATCHDOG=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_SSB=m
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_FB=y
 CONFIG_FB_ATMEL=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.9.1
