From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:10 -0400
Subject: [PATCH 26/37] ARM: mach-nuc93x: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-26-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-nuc93x/include/mach/memory.h |   21 ---------------------
 2 files changed, 1 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-nuc93x/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a2e96e8..a3577a2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -607,6 +607,7 @@ config ARCH_NUC93X
 	bool "Nuvoton NUC93X CPU"
 	select CPU_ARM926T
 	select CLKDEV_LOOKUP
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Nuvoton (Winbond logic dept.) NUC93X MCU,The NUC93X is a
 	  low-power and high performance MPEG-4/JPEG multimedia controller chip.
diff --git a/arch/arm/mach-nuc93x/include/mach/memory.h b/arch/arm/mach-nuc93x/include/mach/memory.h
deleted file mode 100644
index ef9864b..0000000
--- a/arch/arm/mach-nuc93x/include/mach/memory.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-nuc93x/include/mach/memory.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#endif
-- 
1.7.4
