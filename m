From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:59 -0400
Subject: [PATCH 15/37] ARM: mach-pnx4008: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-15-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-pnx4008/include/mach/memory.h |   21 ---------------------
 2 files changed, 1 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index af416fc..4fc61db 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -625,6 +625,7 @@ config ARCH_PNX4008
 	select CPU_ARM926T
 	select CLKDEV_LOOKUP
 	select ARCH_USES_GETTIMEOFFSET
+	select NO_MACH_MEMORY_H
 	help
 	  This enables support for Philips PNX4008 mobile platform.
 
diff --git a/arch/arm/mach-pnx4008/include/mach/memory.h b/arch/arm/mach-pnx4008/include/mach/memory.h
deleted file mode 100644
index 1275db6..0000000
--- a/arch/arm/mach-pnx4008/include/mach/memory.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * arch/arm/mach-pnx4008/include/mach/memory.h
- *
- * Copyright (c) 2005 Philips Semiconductors
- * Copyright (c) 2005 MontaVista Software, Inc.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x80000000)
-
-#endif
-- 
1.7.4
