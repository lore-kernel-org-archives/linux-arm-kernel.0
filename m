From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Nov 2014 11:18:58 +0100
Subject: [PATCH] ARM: at91/at91sam9g45: remove useless header file
Message-ID: <1416392338-30665-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove this useless cpu.h header file forgotten during the !DT support removal.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g45.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 2ad0db4caa9b..3d225105e0d1 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -11,7 +11,6 @@
  */
 
 #include <asm/system_misc.h>
-#include <mach/cpu.h>
 #include <mach/hardware.h>
 
 #include "soc.h"
-- 
2.1.3
