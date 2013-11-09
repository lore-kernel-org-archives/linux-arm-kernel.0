From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat,  9 Nov 2013 17:34:01 +0100
Subject: [PATCH 1/2] ARM: OMAP2+: remove unnecesary include in gpmc driver
Message-ID: <1384014842-4288-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPMC driver includes arch/arm/mach-omap2/common.h but
it does not use anything on that header so can be removed.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 51525fa..bb2c58a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -37,7 +37,6 @@
 #include <asm/mach-types.h>
 
 #include "soc.h"
-#include "common.h"
 #include "omap_device.h"
 #include "gpmc.h"
 #include "gpmc-nand.h"
-- 
1.8.4.rc3
