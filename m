From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 29 Jan 2013 13:49:13 -0200
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Add VPU support
In-Reply-To: <1359474553-8949-1-git-send-email-fabio.estevam@freescale.com>
References: <1359474553-8949-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1359474553-8949-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the VPU driver be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6966713..83822d9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -160,6 +160,8 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_VIDEO_MX3=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CODA=y
 CONFIG_FB=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.7.9.5
