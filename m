From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:36 -0700
Subject: [PATCH 27/29] ARM: OMAP2+: Make l4_2xxx.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210636.28074.93547.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/l4_2xxx.h                      |    0 
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-omap/include/plat/l4_2xxx.h => mach-omap2/l4_2xxx.h} (100%)

diff --git a/arch/arm/plat-omap/include/plat/l4_2xxx.h b/arch/arm/mach-omap2/l4_2xxx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/l4_2xxx.h
rename to arch/arm/mach-omap2/l4_2xxx.h
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index fa8e55b..a1e8f1d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -19,7 +19,7 @@
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
 #include "l3_2xxx.h"
-#include <plat/l4_2xxx.h>
+#include "l4_2xxx.h"
 #include <plat/mmc.h>
 
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 4d1572e..f853a0b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -16,7 +16,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
 #include "l3_2xxx.h"
-#include <plat/l4_2xxx.h>
+#include "l4_2xxx.h"
 
 #include "omap_hwmod_common_data.h"
 
