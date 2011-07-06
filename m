From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:53 -0400
Subject: [PATCH 09/37] ARM: mach-iop33x: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-9-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-iop33x/include/mach/memory.h |   13 -------------
 2 files changed, 1 insertions(+), 13 deletions(-)
 delete mode 100644 arch/arm/mach-iop33x/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8004b4..c4b6e4a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -448,6 +448,7 @@ config ARCH_IOP33X
 	select PLAT_IOP
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Intel's IOP33X (XScale) family of processors.
 
diff --git a/arch/arm/mach-iop33x/include/mach/memory.h b/arch/arm/mach-iop33x/include/mach/memory.h
deleted file mode 100644
index 8e1daf7..0000000
--- a/arch/arm/mach-iop33x/include/mach/memory.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-iop33x/include/mach/memory.h
- */
-
-#ifndef __MEMORY_H
-#define __MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#endif
-- 
1.7.4
