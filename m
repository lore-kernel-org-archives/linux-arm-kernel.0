From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 21 Dec 2015 16:44:02 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
Message-ID: <1450723442-1518-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_DRM_ETNAVIV, so that GPU support can be enabled by default.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 2d5253d..be08ce7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -231,6 +231,7 @@ CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y
 CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_HDMI=y
+CONFIG_DRM_ETNAVIV=y
 CONFIG_FB_MXS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
-- 
1.9.1
