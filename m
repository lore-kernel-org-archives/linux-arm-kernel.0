From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  7 Oct 2012 14:44:17 -0300
Subject: [PATCH] ARM: imx: configs: Enable CONFIG_MEDIA_CAMERA_SUPPORT
Message-ID: <1349631857-31556-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit b4c184e5 (edia] media: reorganize the main Kconfig items),
it is necessary to select CONFIG_MEDIA_CAMERA_SUPPORT in order to be able
to use the SoC camera drivers.

Select CONFIG_MEDIA_CAMERA_SUPPORT so that we can use mx2-camera/mx3-camera
by default as previously.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 78ed575..d100401 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -121,6 +121,7 @@ CONFIG_REGULATOR_MC13892=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_VIDEO_MX2=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 66aa7a6..fcb4b62 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -151,6 +151,7 @@ CONFIG_REGULATOR_MC13892=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_VIDEO_MX3=y
-- 
1.7.9.5
