From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 23 Jul 2018 16:42:27 +0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable DRM_PANEL_SEIKO_43WVF1G
Message-ID: <8c6f4f407f363ec6980b59f7a2a9f29221dac29b.1532353109.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is one of the default lcdif panel options for several imx
development boards. Now that we switched to CONFIG_DRM_MXSFB=y this
should be enabled as well.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c127608bcc..7eca43ff69bb 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -255,10 +255,11 @@ CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV5640=m
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y
-- 
2.17.1
