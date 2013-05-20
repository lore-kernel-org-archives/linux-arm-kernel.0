From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 20 May 2013 10:59:57 -0300
Subject: [PATCH] ARM: imx: imx_v6_v7_defconfig: Select CONFIG_DRM_IMX_TVE
Message-ID: <1369058397-25071-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the mx53 TVE driver be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6ec010f..a50d9af 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -208,6 +208,7 @@ CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
 CONFIG_DRM_IMX=y
+CONFIG_DRM_IMX_TVE=y
 CONFIG_DRM_IMX_IPUV3_CORE=y
 CONFIG_DRM_IMX_IPUV3=y
 CONFIG_COMMON_CLK_DEBUG=y
-- 
1.8.1.2
