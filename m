From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 20 Jan 2015 20:58:00 +0900
Subject: [PATCH 01/03] ARM: shmobile: Remove mach/system.h
In-Reply-To: <20150120115750.11479.95109.sendpatchset@little-apple>
References: <20150120115750.11479.95109.sendpatchset@little-apple>
Message-ID: <20150120115800.11479.87312.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

The file <mach/system.h> is no longer included from anywhere so
clean up the code by removing mach-shmobile/include/mach/system.h

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Applies to renesas-devel-20150119-v3.19-rc5

 arch/arm/mach-shmobile/include/mach/system.h |   11 -----------
 1 file changed, 11 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/system.h
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,11 +0,0 @@
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-#include <asm/system_misc.h>
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-	soft_restart(0);
-}
-
-#endif
