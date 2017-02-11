From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:43:58 +0200
Subject: [PATCH 1/8] ARM: sunxi_defconfig: Enable simple panel
In-Reply-To: <20170211174405.28395-1-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
Message-ID: <20170211174405.28395-2-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Liu <net147@gmail.com>

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index da92c25..7abe6a4 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -153,3 +153,7 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_CRYPTO_DEV_SUN4I_SS=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_DRM_PANEL_SIMPLE=y
-- 
2.9.3
