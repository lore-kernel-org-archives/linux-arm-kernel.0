From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Feb 2012 19:36:11 -0200
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: Update defconfig
In-Reply-To: <1329341771-13749-1-git-send-email-festevam@gmail.com>
References: <1329341771-13749-1-git-send-email-festevam@gmail.com>
Message-ID: <1329341771-13749-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the following drivers to be built by default:
- SMSC911x
- LCD_L4F00242T0 (LCD present on mx27pdk)
- CONFIG_VIDEO_MX2
- OV2640 (Camera present on mx27pdk)
- CONFIG_VIDEO_MX2 (Allow mx2 video capture)

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index a22e930..00d8f8b 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -45,6 +45,7 @@ CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
 CONFIG_PM_DEBUG=y
 CONFIG_NET=y
+CONFIG_SMSC911X=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -115,6 +116,21 @@ CONFIG_FB_IMX=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_LCD_L4F00242T03=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_VIDEO_DEV=y
+CONFIG_VIDEO_V4L2_COMMON=y
+CONFIG_VIDEO_MEDIA=y
+CONFIG_VIDEO_V4L2=y
+CONFIG_VIDEOBUF_GEN=y
+CONFIG_VIDEOBUF_DMA_CONTIG=y
+CONFIG_VIDEOBUF2_CORE=y
+CONFIG_VIDEO_CAPTURE_DRIVERS=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_OV2640=y
+CONFIG_VIDEO_MX2_HOSTSUPPORT=y
+CONFIG_VIDEO_MX2=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
-- 
1.7.1
