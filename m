From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Feb 2018 11:12:00 +0100
Subject: [PATCH] bridge: Elaborate a bit on dumb VGA bridges in Kconfig
Message-ID: <20180227101200.6173-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's better if we explain a bit that this pertains to
passive VGA DAC bridges.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/bridge/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3b99d5a06c16..7cee8f291e7f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -30,7 +30,8 @@ config DRM_DUMB_VGA_DAC
 	depends on OF
 	select DRM_KMS_HELPER
 	help
-	  Support for RGB to VGA DAC based bridges
+	  Support for passive RGB to VGA DAC based bridges such
+	  as ADI ADV7123 or TI THS8134 and THS8135.
 
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
-- 
2.14.3
