From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 16 Nov 2015 10:05:38 -0200
Subject: [PATCH RESEND] ARM: imx_v6_v7_defconfig: Select HDMI audio support
Message-ID: <1447675538-24821-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_DRM_DW_HDMI_AHB_AUDIO so that we have HDMI audio
supported by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
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
