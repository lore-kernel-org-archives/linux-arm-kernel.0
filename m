From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 26 Jul 2013 10:08:06 +0300
Subject: [PATCH 03/21] ARM: OMAP2+: Add selected display drivers to
 omap2plus_defconfig
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1374822504-28949-4-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some of the most common new display drivers to omap2plus_defconfig
to be built as modules.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5339e6a..7ce1c29 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -192,6 +192,11 @@ CONFIG_PANEL_NEC_NL8048HL11_01B=m
 CONFIG_PANEL_TAAL=m
 CONFIG_PANEL_TPO_TD043MTEA1=m
 CONFIG_PANEL_ACX565AKM=m
+CONFIG_DISPLAY_ENCODER_TFP410=m
+CONFIG_DISPLAY_ENCODER_TPD12S015=m
+CONFIG_DISPLAY_CONNECTOR_DVI=m
+CONFIG_DISPLAY_CONNECTOR_HDMI=m
+CONFIG_DISPLAY_PANEL_DPI=m
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
-- 
1.8.1.2
