From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Tue, 9 Apr 2013 11:07:32 -0300
Subject: [PATCH v2 4/4] ARM: imx_v6_v7_defconfig: enable parallel display
In-Reply-To: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1365516452-1287-4-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow parallel display to work by default

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
Changes since v1:
No changes
 arch/arm/configs/imx_v6_v7_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e36b010..4942479 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -162,6 +162,7 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_DRM=y
+CONFIG_OF_VIDEOMODE=y
 CONFIG_VIDEO_MX3=y
 CONFIG_FB=y
 CONFIG_LCD_PLATFORM=y
@@ -206,6 +207,8 @@ CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
 CONFIG_DRM_IMX=y
+CONFIG_DRM_IMX_FB_HELPER=y
+CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_IPUV3_CORE=y
 CONFIG_DRM_IMX_IPUV3=y
 CONFIG_COMMON_CLK_DEBUG=y
-- 
1.7.10.4
