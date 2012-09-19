From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:09 -0700
Subject: [PATCH 14/29] ARM: OMAP2+: Make ctrl_module_wkup_44xx.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210609.28074.12766.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.h                      |    2 +-
 arch/arm/mach-omap2/ctrl_module_wkup_44xx.h        |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/mach-omap2/{include/mach/ctrl_module_wkup_44xx.h => ctrl_module_wkup_44xx.h} (100%)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index dbad6eb..123186a 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -17,7 +17,7 @@
 #define __ARCH_ARM_MACH_OMAP2_CONTROL_H
 
 #include "ctrl_module_core_44xx.h"
-#include <mach/ctrl_module_wkup_44xx.h>
+#include "ctrl_module_wkup_44xx.h"
 #include "ctrl_module_pad_core_44xx.h"
 #include "ctrl_module_pad_wkup_44xx.h"
 
diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h b/arch/arm/mach-omap2/ctrl_module_wkup_44xx.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
rename to arch/arm/mach-omap2/ctrl_module_wkup_44xx.h
