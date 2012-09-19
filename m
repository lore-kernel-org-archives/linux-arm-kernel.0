From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:20 -0700
Subject: [PATCH 19/29] ARM: OMAP2+: Make debug-devices.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210620.28074.70959.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c                  |    2 +-
 arch/arm/mach-omap2/debug-devices.h             |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/{plat-omap/include/plat/debug-devices.h => mach-omap2/debug-devices.h} (100%)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 12569cb..f6c48dd 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -34,7 +34,7 @@
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
-#include <plat/debug-devices.h>
+#include "debug-devices.h"
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/plat-omap/include/plat/debug-devices.h b/arch/arm/mach-omap2/debug-devices.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/debug-devices.h
rename to arch/arm/mach-omap2/debug-devices.h
