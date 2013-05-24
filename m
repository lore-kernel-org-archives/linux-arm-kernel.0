From: rogerio.pimentel@freescale.com (Rogerio Pimentel)
Date: Fri, 24 May 2013 11:09:31 -0300
Subject: [PATCH v3 2/2] ARM:imx_v6_v7_defconfig: enable parallel display
In-Reply-To: <1369404571-21356-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1369404571-21356-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1369404571-21356-2-git-send-email-rogerio.pimentel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable paralell display by default

Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
---
Changes since V2:
CONFIG_OF_VIDEOMODE doesn't need to be added on defconfig
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6ec010f..7085c7a 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -208,6 +208,8 @@ CONFIG_IMX_SDMA=y
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
