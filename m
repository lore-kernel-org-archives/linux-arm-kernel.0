From: tony@atomide.com (Tony Lindgren)
Date: Fri,  9 Feb 2018 09:43:38 -0800
Subject: [PATCH] ARM: OMAP2+: Fix typo for wakeup_ns_pa_addr
Message-ID: <20180209174338.30563-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is in bank1, not in bank3.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap4-sar-layout.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
--- a/arch/arm/mach-omap2/omap4-sar-layout.h
+++ b/arch/arm/mach-omap2/omap4-sar-layout.h
@@ -28,7 +28,7 @@
 #define L2X0_AUXCTRL_OFFSET			0xff8
 #define L2X0_PREFETCH_CTRL_OFFSET		0xffc
 
-/* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
+/* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK1 */
 #define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
 #define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
 #define OMAP5_CPU0_WAKEUP_NS_PA_ADDR_OFFSET	0xe00
-- 
2.16.1
