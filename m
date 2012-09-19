From: tony@atomide.com (Tony Lindgren)
Date: Wed, 19 Sep 2012 14:06:03 -0700
Subject: [PATCH 11/29] ARM: OMAP2+: Make ctrl_module_core_44xx.h local
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Message-ID: <20120919210603.28074.17934.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.h                      |    2 +-
 arch/arm/mach-omap2/ctrl_module_core_44xx.h        |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/mach-omap2/{include/mach/ctrl_module_core_44xx.h => ctrl_module_core_44xx.h} (100%)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index c1a5cab..2d25478 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CONTROL_H
 #define __ARCH_ARM_MACH_OMAP2_CONTROL_H
 
-#include <mach/ctrl_module_core_44xx.h>
+#include "ctrl_module_core_44xx.h"
 #include <mach/ctrl_module_wkup_44xx.h>
 #include <mach/ctrl_module_pad_core_44xx.h>
 #include <mach/ctrl_module_pad_wkup_44xx.h>
diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h b/arch/arm/mach-omap2/ctrl_module_core_44xx.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
rename to arch/arm/mach-omap2/ctrl_module_core_44xx.h
