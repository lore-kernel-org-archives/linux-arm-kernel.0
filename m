From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  9 Feb 2016 19:45:04 +0100
Subject: [PATCH] ARM: shmobile: r8a7740: Remove obsolete #include
 <asm/hardware/cache-l2x0.h>
Message-ID: <1455043504-27933-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 540977ae9746e60c ("ARM: shmobile: r8a7740: Migrate to
generic l2c OF initialization"), no l2x0 functionality is used from
platform code, so the include can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
As you plan to respin renesas-dt-for-v4.6, perhaps this can still be
folded in the original commit?

 arch/arm/mach-shmobile/setup-r8a7740.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 496569f9d578b863..3e71cd4168dd00cb 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -23,7 +23,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #include "common.h"
 
-- 
1.9.1
