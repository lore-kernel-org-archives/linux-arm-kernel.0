From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Dec 2012 10:07:52 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select IPUV3 driver
Message-ID: <1356437272-1679-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let IPUV3 driver be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 6966713..a613eb7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -159,6 +159,7 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
+CONFIG_DRM=y
 CONFIG_VIDEO_MX3=y
 CONFIG_FB=y
 CONFIG_LCD_PLATFORM=y
@@ -200,6 +201,10 @@ CONFIG_RTC_DRV_MXC=y
 CONFIG_DMADEVICES=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
+CONFIG_STAGING=y
+CONFIG_DRM_IMX=y
+CONFIG_DRM_IMX_IPUV3_CORE=y
+CONFIG_DRM_IMX_IPUV3=y
 CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
-- 
1.7.9.5
