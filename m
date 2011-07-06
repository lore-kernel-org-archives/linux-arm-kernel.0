From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:58 -0400
Subject: [PATCH 14/37] ARM: mach-w90x900: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-14-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-w90x900/include/mach/memory.h |   23 -----------------------
 2 files changed, 1 insertions(+), 23 deletions(-)
 delete mode 100644 arch/arm/mach-w90x900/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8690b96..af416fc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -587,6 +587,7 @@ config ARCH_W90X900
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
 	  At present, the w90x900 has been renamed nuc900, regarding
diff --git a/arch/arm/mach-w90x900/include/mach/memory.h b/arch/arm/mach-w90x900/include/mach/memory.h
deleted file mode 100644
index f02905b..0000000
--- a/arch/arm/mach-w90x900/include/mach/memory.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * arch/arm/mach-w90x900/include/mach/memory.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- *
- * Based on arch/arm/mach-s3c2410/include/mach/memory.h
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
