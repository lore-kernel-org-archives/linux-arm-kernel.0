From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:12 -0400
Subject: [PATCH 28/37] ARM: mach-mmp: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-28-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mmp/include/mach/memory.h |   14 --------------
 2 files changed, 1 insertions(+), 14 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab78899..16dcd0a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -575,6 +575,7 @@ config ARCH_MMP
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
diff --git a/arch/arm/mach-mmp/include/mach/memory.h b/arch/arm/mach-mmp/include/mach/memory.h
deleted file mode 100644
index d68b50a..0000000
--- a/arch/arm/mach-mmp/include/mach/memory.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/memory.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_MACH_MEMORY_H
-#define __ASM_MACH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#endif /* __ASM_MACH_MEMORY_H */
-- 
1.7.4
