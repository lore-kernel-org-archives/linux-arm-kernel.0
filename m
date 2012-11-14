From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 14 Nov 2012 16:20:37 -0200
Subject: [PATCH v2 2/2] ARM: imx_v4_v5_defconfig: Add VPU support
In-Reply-To: <1352917238-29694-1-git-send-email-fabio.estevam@freescale.com>
References: <1352917238-29694-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1352917238-29694-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the VPU driver be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix the dependencies
 arch/arm/configs/imx_v4_v5_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index f71302c..a5f12ff 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -121,11 +121,14 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
 CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SOC_CAMERA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_VIDEO_MX2=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_CODA=y
 CONFIG_FB=y
 CONFIG_FB_IMX=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
-- 
1.7.9.5
