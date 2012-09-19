From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:18 -0700
Subject: [PATCH 18/29] ARM: OMAP1: Move board-voiceblue.h from plat to mach
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210617.28074.97081.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only used by omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-voiceblue.c              |    2 +-
 arch/arm/mach-omap1/include/mach/board-voiceblue.h |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/{plat-omap/include/plat/board-voiceblue.h => mach-omap1/include/mach/board-voiceblue.h} (100%)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index bd7b3fc..64289ea 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -31,7 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board-voiceblue.h>
+#include <mach/board-voiceblue.h>
 #include <plat/flash.h>
 #include <mach/mux.h>
 #include <plat/tc.h>
diff --git a/arch/arm/plat-omap/include/plat/board-voiceblue.h b/arch/arm/mach-omap1/include/mach/board-voiceblue.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/board-voiceblue.h
rename to arch/arm/mach-omap1/include/mach/board-voiceblue.h
