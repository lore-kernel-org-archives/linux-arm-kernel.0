From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:13 -0400
Subject: [PATCH 29/37] ARM: plat-tcc: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-29-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/plat-tcc/include/mach/memory.h |   18 ------------------
 2 files changed, 1 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm/plat-tcc/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 16dcd0a..8b221f2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -829,6 +829,7 @@ config ARCH_TCC_926
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Telechips TCC ARM926-based systems.
 
diff --git a/arch/arm/plat-tcc/include/mach/memory.h b/arch/arm/plat-tcc/include/mach/memory.h
deleted file mode 100644
index 28a6e0c..0000000
--- a/arch/arm/plat-tcc/include/mach/memory.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright (C) 1999 ARM Limited
- * Copyright (C) 2000 RidgeRun, Inc.
- * Copyright (C) 2008-2009 Telechips
- * Copyright (C) 2010 Hans J. Koch <hjk@linutronix.de>
- *
- * Licensed under the terms of the GPL v2.
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET		UL(0x20000000)
-
-#endif
-- 
1.7.4
