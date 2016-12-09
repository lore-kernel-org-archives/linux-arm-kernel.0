From: khilman@baylibre.com (Kevin Hilman)
Date: Thu,  8 Dec 2016 16:57:56 -0800
Subject: [PATCH] ARM64: defconfig: enable DRM_MESON as module
Message-ID: <20161209005756.12599-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
To be added when the DRM driver lands upstream.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0f9d8900d685..2ce367dffb05 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -301,6 +301,7 @@ CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_HISI_KIRIN=m
+CONFIG_DRM_MESON=m
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_BACKLIGHT_GENERIC=m
-- 
2.9.3
