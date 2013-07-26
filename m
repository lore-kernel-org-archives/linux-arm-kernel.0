From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 26 Jul 2013 10:08:24 +0300
Subject: [PATCH 21/21] ARM: OMAP2+: Remove old display drivers from
 omap2plus_defconfig
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1374822504-28949-22-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old display drivers are no longer used, and will be phased out. So
remove them from the omap2plus_defconfig.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 7ce1c29..92ba100 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -185,13 +185,6 @@ CONFIG_OMAP2_DSS_RFBI=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
 CONFIG_FB_OMAP2=m
-CONFIG_PANEL_GENERIC_DPI=m
-CONFIG_PANEL_TFP410=m
-CONFIG_PANEL_SHARP_LS037V7DW01=m
-CONFIG_PANEL_NEC_NL8048HL11_01B=m
-CONFIG_PANEL_TAAL=m
-CONFIG_PANEL_TPO_TD043MTEA1=m
-CONFIG_PANEL_ACX565AKM=m
 CONFIG_DISPLAY_ENCODER_TFP410=m
 CONFIG_DISPLAY_ENCODER_TPD12S015=m
 CONFIG_DISPLAY_CONNECTOR_DVI=m
-- 
1.8.1.2
