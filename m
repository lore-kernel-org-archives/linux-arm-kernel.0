From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:47:06 +0900
Subject: [PATCH 03/03] ARM: shmobile: Remove mach/memory.h
In-Reply-To: <20130610094638.20803.18484.sendpatchset@w520>
References: <20130610094638.20803.18484.sendpatchset@w520>
Message-ID: <20130610094706.20803.55146.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove mach-shmobile memory.h since it is no longer needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/memory.h |    7 -------
 1 file changed, 7 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/memory.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_MEMORY_H
-#define __ASM_MACH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(CONFIG_MEMORY_START)
-#define MEM_SIZE	UL(CONFIG_MEMORY_SIZE)
-
-#endif /* __ASM_MACH_MEMORY_H */
