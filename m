From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:01 -0700
Subject: [PATCH 10/29] ARM: OMAP2+: Make board-rx51.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210601.28074.66797.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c  |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c        |    2 +-
 arch/arm/mach-omap2/board-rx51.h              |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-omap2/{include/mach/board-rx51.h => board-rx51.h} (100%)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 5b2edfe..bf78ad4 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -35,7 +35,7 @@
 #include <plat/gpmc-smc91x.h>
 #include <plat/omap-pm.h>
 
-#include <mach/board-rx51.h>
+#include "board-rx51.h"
 
 #include <sound/tlv320aic3x.h>
 #include <sound/tpa6130a2-plat.h>
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 2c1289b..6e5b196 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -19,7 +19,7 @@
 #include <plat/vram.h>
 #include <plat/mcspi.h>
 
-#include <mach/board-rx51.h>
+#include "board-rx51.h"
 
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/include/mach/board-rx51.h b/arch/arm/mach-omap2/board-rx51.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/board-rx51.h
rename to arch/arm/mach-omap2/board-rx51.h
