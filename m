From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:28 -0700
Subject: [PATCH 23/29] ARM: OMAP2+: Make hdq1w.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210628.28074.67963.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hdq1w.c                        |    2 +-
 arch/arm/mach-omap2/hdq1w.h                        |    0 
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-omap/include/plat/hdq1w.h => mach-omap2/hdq1w.h} (100%)

diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index cdd6dda..e003f2b 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -29,7 +29,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
-#include <plat/hdq1w.h>
+#include "hdq1w.h"
 
 #include "common.h"
 
diff --git a/arch/arm/plat-omap/include/plat/hdq1w.h b/arch/arm/mach-omap2/hdq1w.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/hdq1w.h
rename to arch/arm/mach-omap2/hdq1w.h
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index bea700e..8851bbb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -13,7 +13,7 @@
 #include <plat/serial.h>
 #include <plat/dma.h>
 #include <plat/common.h>
-#include <plat/hdq1w.h>
+#include "hdq1w.h"
 
 #include "omap_hwmod_common_data.h"
 
