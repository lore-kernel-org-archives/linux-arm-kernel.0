From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 2 Jul 2014 11:47:45 +0300
Subject: [PATCH 11/13] ARM: OMAP2+: clock/dpll: remove unused header includes
 from clkt_dpll.c
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Message-ID: <1404290867-6768-12-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the machine specific header includes are no longer used, so remove
these from the source file. This allows migration of the file under clock
driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 51f995a..cdc3674 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -21,10 +21,7 @@
 
 #include <asm/div64.h>
 
-#include "soc.h"
 #include "clock.h"
-#include "cm-regbits-24xx.h"
-#include "cm-regbits-34xx.h"
 
 /* DPLL rate rounding: minimum DPLL multiplier, divider values */
 #define DPLL_MIN_MULTIPLIER		2
-- 
1.7.9.5
