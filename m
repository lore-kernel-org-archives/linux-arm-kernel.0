From: denis@eukrea.com (Denis Carikli)
Date: Mon,  7 Apr 2014 14:44:51 +0200
Subject: [PATCH v12][ 12/12] ARM: imx_v6_v7_defconfig: Add more drm drivers.
In-Reply-To: <1396874691-27954-1-git-send-email-denis@eukrea.com>
References: <1396874691-27954-1-git-send-email-denis@eukrea.com>
Message-ID: <1396874691-27954-12-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRM_PANEL_SIMPLE is needed by the eukrea
mbimxsd51's displays.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v10->v11:
- New patch, splitting it would be overkill.
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 09e9743..0316926 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -183,6 +183,7 @@ CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_CODA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_DRM=y
+CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
@@ -245,6 +246,7 @@ CONFIG_DRM_IMX_TVE=y
 CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_IPUV3_CORE=y
 CONFIG_DRM_IMX_IPUV3=y
+CONFIG_DRM_IMX_HDMI=y
 CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
-- 
1.7.9.5
