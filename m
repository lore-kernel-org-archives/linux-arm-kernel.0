From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Nov 2018 10:57:31 +0100
Subject: [PATCH] ARM: shmobile: sh73a0: Remove obsolete inclusion of
 <asm/smp_twd.h>
Message-ID: <20181115095731.17362-1-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 9a9863987bf7307f ("ARM: shmobile: Remove legacy SoC code
for SH-Mobile AG5"), this header file is no longer used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/smp-sh73a0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 9bc543faba96af6e..0403aa8629ddc10a 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -12,7 +12,6 @@
 #include <linux/delay.h>
 
 #include <asm/smp_plat.h>
-#include <asm/smp_twd.h>
 
 #include "common.h"
 #include "sh73a0.h"
-- 
2.17.1
