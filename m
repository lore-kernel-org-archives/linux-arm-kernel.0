From: tony@atomide.com (Tony Lindgren)
Date: Thu,  1 Mar 2018 14:17:02 -0800
Subject: [PATCH 08/10] ARM: omap2plus_defconfig: Enable CEC
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Message-ID: <20180301221704.104530-9-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have CEC support available and working so let's enable it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -327,10 +327,12 @@ CONFIG_IR_GPIO_TX=m
 CONFIG_IR_PWM_TX=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CEC_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_OMAP3=m
+CONFIG_CEC_PLATFORM_DRIVERS=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_TVP5150=m
 CONFIG_FB=y
-- 
2.16.2
