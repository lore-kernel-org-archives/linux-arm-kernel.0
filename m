From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:39 -0700
Subject: [PATCH 28/29] ARM: OMAP2+: Make l4_3xxx.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210639.28074.57305.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/l4_3xxx.h              |    0 
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/{plat-omap/include/plat/l4_3xxx.h => mach-omap2/l4_3xxx.h} (100%)

diff --git a/arch/arm/plat-omap/include/plat/l4_3xxx.h b/arch/arm/mach-omap2/l4_3xxx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/l4_3xxx.h
rename to arch/arm/mach-omap2/l4_3xxx.h
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 13a9aa8..1c6d763 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,7 +21,7 @@
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include "l3_3xxx.h"
-#include <plat/l4_3xxx.h>
+#include "l4_3xxx.h"
 #include <plat/i2c.h>
 #include <plat/mmc.h>
 #include <plat/mcbsp.h>
