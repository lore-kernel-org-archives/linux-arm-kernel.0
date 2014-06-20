From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jun 2014 00:02:24 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable CONFIG_IMX_IPUV3_CORE
Message-ID: <1403233344-28333-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 39b9004d1f (gpu: ipu-v3: Move i.MX IPUv3 core driver out of 
staging) the ipuv3 core driver is no longer built bey default.

Select CONFIG_IMX_IPUV3_CORE so that the core ipuv3 code can be built again.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index a6f182e..64b078d 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -187,6 +187,7 @@ CONFIG_VIDEO_MX3=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=y
 CONFIG_SOC_CAMERA_OV2640=y
+CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.8.3.2
