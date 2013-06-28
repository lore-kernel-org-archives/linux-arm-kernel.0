From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Jun 2013 00:28:07 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable LVDS Display Bridge
Message-ID: <1372390087-7362-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let IMX_LDB driver be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0837aae..75514e9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -215,6 +215,7 @@ CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_TVE=y
+CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_FB_HELPER=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_IPUV3_CORE=y
-- 
1.8.1.2
