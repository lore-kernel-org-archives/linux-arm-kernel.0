From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:15 -0400
Subject: [PATCH 31/37] ARM: mach-s5pc100: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-31-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-s5pc100/include/mach/memory.h |   18 ------------------
 2 files changed, 1 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5eedf03..12b07d1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -778,6 +778,7 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NO_MACH_MEMORY_H
 	help
 	  Samsung S5PC100 series based systems
 
diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/mach-s5pc100/include/mach/memory.h
deleted file mode 100644
index bda4e79..0000000
--- a/arch/arm/mach-s5pc100/include/mach/memory.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/memory.h
- *
- * Copyright 2008 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * Based on mach-s3c6400/include/mach/memory.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET     	UL(0x20000000)
-
-#endif
-- 
1.7.4
