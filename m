From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:02 -0400
Subject: [PATCH 18/37] ARM: mach-ux500: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-18-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-ux500/include/mach/memory.h |   18 ------------------
 2 files changed, 1 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eef880d..24ad871 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -846,6 +846,7 @@ config ARCH_U8500
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
+	select NO_MACH_MEMORY_H
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
diff --git a/arch/arm/mach-ux500/include/mach/memory.h b/arch/arm/mach-ux500/include/mach/memory.h
deleted file mode 100644
index 2ef697a..0000000
--- a/arch/arm/mach-ux500/include/mach/memory.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright (C) 2009 ST-Ericsson
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-#define BUS_OFFSET	UL(0x00000000)
-
-#endif
-- 
1.7.4
