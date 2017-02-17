From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Feb 2017 06:51:17 -0800
Subject: [PATCH] ARM: omap2plus_defconfig: Enable INPUT_MOUSEDEV as loadable
 modules
Message-ID: <20170217145117.26622-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise mice won't be happy.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -189,6 +189,7 @@ CONFIG_WL12XX=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SPI=m
 CONFIG_WLCORE_SDIO=m
+CONFIG_INPUT_MOUSEDEV=m
 CONFIG_INPUT_JOYDEV=m
 CONFIG_INPUT_EVDEV=m
 CONFIG_KEYBOARD_ATKBD=m
-- 
2.11.1
