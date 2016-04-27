From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 17:01:06 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Enable PWM and ir-rx51 as loadable
 modules
Message-ID: <1461715266-11250-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are available on n900.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d2c105e..b54d17d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -284,8 +284,12 @@ CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_RC_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
+CONFIG_LIRC=m
+CONFIG_RC_DEVICES=y
+CONFIG_IR_RX51=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_OMAP3=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
@@ -421,6 +425,7 @@ CONFIG_TI_EMIF=m
 CONFIG_IIO=m
 CONFIG_TI_AM335X_ADC=m
 CONFIG_PWM=y
+CONFIG_PWM_OMAP_DMTIMER=m
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_TWL=m
-- 
2.8.1
