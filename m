From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  7 Jan 2013 18:37:22 -0200
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Add VPU/EMMAPRP and DEINTERLACE
Message-ID: <1357591042-7637-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let VPU, EMMAPRP and DEINTERLACE drivers be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index ebbfb27..d384aa1 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -127,6 +127,10 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_VIDEO_MX2=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CODA=y
+CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
+CONFIG_VIDEO_MX2_EMMAPRP=y
 CONFIG_FB=y
 CONFIG_FB_IMX=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.7.9.5
