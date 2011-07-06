From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:19 -0400
Subject: [PATCH 35/37] ARM: mach-h720x: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-35-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-h720x/include/mach/memory.h |   11 -----------
 2 files changed, 1 insertions(+), 11 deletions(-)
 delete mode 100644 arch/arm/mach-h720x/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 63ac56d..e105da4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -425,6 +425,7 @@ config ARCH_H720X
 	select CPU_ARM720T
 	select ISA_DMA_API
 	select ARCH_USES_GETTIMEOFFSET
+	select NO_MACH_MEMORY_H
 	help
 	  This enables support for systems based on the Hynix HMS720x
 
diff --git a/arch/arm/mach-h720x/include/mach/memory.h b/arch/arm/mach-h720x/include/mach/memory.h
deleted file mode 100644
index 96dcf50..0000000
--- a/arch/arm/mach-h720x/include/mach/memory.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * arch/arm/mach-h720x/include/mach/memory.h
- *
- * Copyright (c) 2000 Jungjun Kim
- *
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(0x40000000)
-#endif
-- 
1.7.4
