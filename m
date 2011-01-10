From: r64343@freescale.com (Jason Liu)
Date: Tue, 11 Jan 2011 05:44:29 +0800
Subject: [PATCH 1/1] ARM i.MX50: Rename devices-mx50.h
Message-ID: <1294695869-6653-1-git-send-email-r64343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are devices-imx51.h and devices-imx53.h under
arch/arm/mach-mx5 directory. So, had better rename
devices-mx50.h to devices-imx50.h to follow the same
naming convention with imx51 and imx53 part.

Signed-off-by: Jason Liu <r64343@freescale.com>
---
 arch/arm/mach-mx5/board-mx50_rdp.c                 |    2 +-
 .../mach-mx5/{devices-mx50.h => devices-imx50.h}   |    0
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index fd32e4c..e5bb600 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -35,7 +35,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include "devices-mx50.h"
+#include "devices-imx50.h"
 
 static iomux_v3_cfg_t mx50_rdp_pads[] __initdata = {
 	/* SD1 */
diff --git a/arch/arm/mach-mx5/devices-mx50.h b/arch/arm/mach-mx5/devices-imx50.h
similarity index 100%
rename from arch/arm/mach-mx5/devices-mx50.h
rename to arch/arm/mach-mx5/devices-imx50.h
-- 
1.7.0.4
