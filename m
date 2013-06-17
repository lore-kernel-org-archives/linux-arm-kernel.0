From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 17:12:46 +0900
Subject: [PATCH 13/15] ARM: shmobile: Remove mach/memory.h
In-Reply-To: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
References: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371456768-1084-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove mach-shmobile memory.h since it is no longer needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/memory.h |    7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/memory.h

diff --git a/arch/arm/mach-shmobile/include/mach/memory.h b/arch/arm/mach-shmobile/include/mach/memory.h
deleted file mode 100644
index 0ffbe81..0000000
--- a/arch/arm/mach-shmobile/include/mach/memory.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_MEMORY_H
-#define __ASM_MACH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(CONFIG_MEMORY_START)
-#define MEM_SIZE	UL(CONFIG_MEMORY_SIZE)
-
-#endif /* __ASM_MACH_MEMORY_H */
-- 
1.7.10.4
