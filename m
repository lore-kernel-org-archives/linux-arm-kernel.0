From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:56 -0400
Subject: [PATCH 12/37] ARM: mach-mv78xx0: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-12-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-mv78xx0/include/mach/memory.h |   10 ----------
 2 files changed, 1 insertions(+), 10 deletions(-)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 869c7b6..790071c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -538,6 +538,7 @@ config ARCH_MV78XX0
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select PLAT_ORION
+	select NO_MACH_MEMORY_H
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
 	  MV781x0, MV782x0.
diff --git a/arch/arm/mach-mv78xx0/include/mach/memory.h b/arch/arm/mach-mv78xx0/include/mach/memory.h
deleted file mode 100644
index a648c51..0000000
--- a/arch/arm/mach-mv78xx0/include/mach/memory.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/memory.h
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-
-#endif
-- 
1.7.4
