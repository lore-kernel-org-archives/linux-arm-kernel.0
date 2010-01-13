From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 13 Jan 2010 13:03:41 +0100
Subject: [PATCH] ARM: Make raumfeld.c compile
Message-ID: <1263384221-29704-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
Eric, as the original patch isn't merged yet, you can also squash this one
if you like, whatever works better for you.

 arch/arm/mach-pxa/raumfeld.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 9aff746..90302f8 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -52,10 +52,11 @@
 #include <mach/pxa3xx-regs.h>
 #include <mach/mfp-pxa3xx.h>
 #include <mach/mfp-pxa300.h>
-#include <mach/pxa3xx_nand.h>
 #include <mach/ohci.h>
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
+
+#include <plat/pxa3xx_nand.h>
 #include <plat/i2c.h>
 
 #include "generic.h"
-- 
1.6.5.2
