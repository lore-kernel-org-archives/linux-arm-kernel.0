From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:32 -0700
Subject: [PATCH 25/29] ARM: OMAP2+: Make l3_2xxx.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210632.28074.8073.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/l3_2xxx.h                      |    0 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/{plat-omap/include/plat/l3_2xxx.h => mach-omap2/l3_2xxx.h} (100%)

diff --git a/arch/arm/plat-omap/include/plat/l3_2xxx.h b/arch/arm/mach-omap2/l3_2xxx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/l3_2xxx.h
rename to arch/arm/mach-omap2/l3_2xxx.h
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 4e81637..fa8e55b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -18,7 +18,7 @@
 #include <plat/i2c.h>
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
-#include <plat/l3_2xxx.h>
+#include "l3_2xxx.h"
 #include <plat/l4_2xxx.h>
 #include <plat/mmc.h>
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index ceb23c3..f19460e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -20,7 +20,7 @@
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
 #include <plat/mmc.h>
-#include <plat/l3_2xxx.h>
+#include "l3_2xxx.h"
 
 #include "soc.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 5178e40..4d1572e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -15,7 +15,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
-#include <plat/l3_2xxx.h>
+#include "l3_2xxx.h"
 #include <plat/l4_2xxx.h>
 
 #include "omap_hwmod_common_data.h"
