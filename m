From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 May 2017 16:31:31 +0530
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable USB audio/video device
 support
In-Reply-To: <cover.1495104570.git.nsekhar@ti.com>
References: <cover.1495104570.git.nsekhar@ti.com>
Message-ID: <339ab84782b3bc6b793069f18e24ac55feb1c3ec.1495104570.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for USB audio and video camera devices.

Tested on OMAP-L138 LCDK using Logitech webcam and
Plantronics headset.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index d8cdcfaa0206..be69dd4075f0 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -130,6 +130,8 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_DAVINCI_VPIF_DISPLAY=m
 CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE=m
@@ -146,6 +148,7 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
+CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_EDMA_SOC=m
 CONFIG_SND_DA850_SOC_EVM=m
-- 
2.9.0
