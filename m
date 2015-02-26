From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:30 +0900
Subject: [PATCH 1/4] ARM: shmobile: Remove mach/system.h
In-Reply-To: <cover.1424931049.git.horms+renesas@verge.net.au>
References: <cover.1424931049.git.horms+renesas@verge.net.au>
Message-ID: <4fa9c6e24b2dbb1bdc62280834c07c34d7d9c1f0.1424931049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

The file <mach/system.h> is no longer included from anywhere so
clean up the code by removing mach-shmobile/include/mach/system.h

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/system.h | 11 -----------
 1 file changed, 11 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/system.h

diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
deleted file mode 100644
index 540eaff..0000000
--- a/arch/arm/mach-shmobile/include/mach/system.h
+++ /dev/null
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
-- 
2.1.4
