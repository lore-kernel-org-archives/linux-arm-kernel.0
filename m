From: vikram.pandita@ti.com (vikram pandita)
Date: Fri, 13 Nov 2009 17:37:35 -0800
Subject: [PATCH] omap: zoom2: update defconfig for LL_DEBUG_NONE
Message-ID: <mailman.34.1258416210.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update DEBUG_LL for zoom2 board as CONFIG_OMAP_LL_DEBUG_NONE

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index a32d126..eef9362 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -202,7 +202,8 @@ CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
 # CONFIG_OMAP_LL_DEBUG_UART1 is not set
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
-CONFIG_OMAP_LL_DEBUG_UART3=y
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_LL_DEBUG_NONE=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
 
