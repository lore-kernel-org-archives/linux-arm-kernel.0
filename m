From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 29 Nov 2013 20:18:16 +0100
Subject: [PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC driver
In-Reply-To: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1385752697-13700-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPMC driver includes arch/arm/mach-omap2/common.h but
does not use anything on that header so it can be removed.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d24926e..9035cd4 100644
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
1.8.4.2
