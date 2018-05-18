From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:30 +0200
Subject: [PATCH 4/6] ARM: multi_v7_defconfig: Disable CONFIG_FB_SH_MOBILE_MERAM
In-Reply-To: <cover.1526548577.git.horms+renesas@verge.net.au>
References: <cover.1526548577.git.horms+renesas@verge.net.au>
Message-ID: <57eec170e9547bbbf5cc3634ef0d0d29349e8fdf.1526548577.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The last Renesas ARM platform using this driver was removed in commit
a521422ea4ae6128 ("ARM: shmobile: mackerel: Remove Legacy C board
code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 861403da4b10..c6042475bece 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -651,7 +651,6 @@ CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SIMPLE=y
-CONFIG_FB_SH_MOBILE_MERAM=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
-- 
2.11.0
