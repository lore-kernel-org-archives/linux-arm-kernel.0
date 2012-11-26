From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 26 Nov 2012 13:21:53 +0530
Subject: [PATCH] ARM: Exynos: Remove unused regs-mem.h file
Message-ID: <1353916313-14343-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unused regs-mem.h file

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/include/mach/regs-mem.h |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mem.h

diff --git a/arch/arm/mach-exynos/include/mach/regs-mem.h b/arch/arm/mach-exynos/include/mach/regs-mem.h
deleted file mode 100644
index 0368b5a..0000000
--- a/arch/arm/mach-exynos/include/mach/regs-mem.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/regs-mem.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - SROMC and DMC register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_MEM_H
-#define __ASM_ARCH_REGS_MEM_H __FILE__
-
-#include <mach/map.h>
-
-#define S5P_DMC0_MEMCON_OFFSET		0x04
-
-#define S5P_DMC0_MEMTYPE_SHIFT		8
-#define S5P_DMC0_MEMTYPE_MASK		0xF
-
-#endif /* __ASM_ARCH_REGS_MEM_H */
-- 
1.6.6.rc2
