From: hanetzer@startmail.com (Marty E. Plummer)
Date: Sun, 23 Sep 2018 09:20:05 -0500
Subject: [PATCH] drm/rockchip: typo: selet->select
Message-ID: <20180923142005.23915-1-hanetzer@startmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc76217ee4..7d1ccc9efc76 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -23,7 +23,7 @@ config ROCKCHIP_ANALOGIX_DP
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Analogix Core DP driver. If you want to enable DP
-	  on RK3288 based SoC, you should selet this option.
+	  on RK3288 based SoC, you should select this option.
 
 config ROCKCHIP_CDN_DP
         bool "Rockchip cdn DP"
@@ -39,7 +39,7 @@ config ROCKCHIP_DW_HDMI
         help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Synopsys DesignWare HDMI driver. If you want to
-	  enable HDMI on RK3288 based SoC, you should selet this
+	  enable HDMI on RK3288 based SoC, you should select this
 	  option.
 
 config ROCKCHIP_DW_MIPI_DSI
@@ -47,7 +47,7 @@ config ROCKCHIP_DW_MIPI_DSI
 	help
 	 This selects support for Rockchip SoC specific extensions
 	 for the Synopsys DesignWare HDMI driver. If you want to
-	 enable MIPI DSI on RK3288 based SoC, you should selet this
+	 enable MIPI DSI on RK3288 based SoC, you should select this
 	 option.
 
 config ROCKCHIP_INNO_HDMI
-- 
2.19.0
