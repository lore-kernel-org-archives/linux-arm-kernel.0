From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Oct 2015 09:48:44 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select HDMI audio support
Message-ID: <1444654124-8248-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select CONFIG_DRM_DW_HDMI_AHB_AUDIO so that we have HDMI audio
supported by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

Should this one go via Russell's tree, which contains the patches
that add HDMI audio support?

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4187f69..f5ca938 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -224,6 +224,7 @@ CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_DW_HDMI_AHB_AUDIO=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_FB_HELPER=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
-- 
1.9.1
