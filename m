From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 14 Feb 2012 13:40:21 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add support for framebuffer and
 camera on mx31
Message-ID: <1329234021-20540-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let framebuffer and camera support be built by default on mx31.

Tested on a mx31pdk board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This applies against linux-next
 arch/arm/configs/imx_v6_v7_defconfig |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a4fb2e..cf258c6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -126,7 +126,39 @@ CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_MC13XXX=y
 CONFIG_REGULATOR=y
+CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_VIDEO_V4L2=y
+CONFIG_VIDEO_DEV=y
+CONFIG_VIDEO_V4L2_COMMON=y
+CONFIG_VIDEOBUF_GEN=y
+CONFIG_VIDEOBUF2_CORE=y
+CONFIG_VIDEOBUF2_MEMOPS=y
+CONFIG_VIDEOBUF2_DMA_CONTIG=y
+CONFIG_VIDEO_CAPTURE_DRIVERS=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_OV2640=y
+CONFIG_MX3_VIDEO=y
+CONFIG_VIDEO_MX3=y
+CONFIG_FB=y
+CONFIG_FB_MX3=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_L4F00242T03=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_GENERIC=y
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_MONO=y
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
-- 
1.7.1
