From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 14 Jan 2015 10:41:55 +0800
Subject: [PATCH v2 8/8] ARM: at91: sama5: enable atmel-isi and ov2640 in
 defconfig
In-Reply-To: <1421203315-27619-1-git-send-email-josh.wu@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
 <1421203315-27619-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1421203315-27619-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/sama5_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index b58fb32..92f1d71 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -139,6 +139,12 @@ CONFIG_POWER_RESET=y
 CONFIG_SSB=m
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_ACT8865=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_OV2640=y
+CONFIG_VIDEO_ATMEL_ISI=y
 CONFIG_FB=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
1.9.1
