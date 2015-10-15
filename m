From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:34:03 +0900
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: enable HDMI output for Renesas
 RCar
In-Reply-To: <cover.1444869086.git.horms+renesas@verge.net.au>
References: <cover.1444869086.git.horms+renesas@verge.net.au>
Message-ID: <fec3fb4734b4d2c33975077c250ebd4a3a9f8e34.1444869086.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Actviate HDMI output of the RCar DU (and LVDS while we are here).
Enable the HDMI encoder chip found on Lager/Koelsch boards.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e682da3f9d42..a5c6ebf39b0a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -440,6 +440,7 @@ CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_ML86V7667=m
 CONFIG_DRM=y
+CONFIG_DRM_I2C_ADV7511=m
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
 CONFIG_DRM_NXP_PTN3460=m
@@ -450,6 +451,8 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_RCAR_DU=m
+CONFIG_DRM_RCAR_HDMI=y
+CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_PANEL_SIMPLE=y
-- 
2.1.4
