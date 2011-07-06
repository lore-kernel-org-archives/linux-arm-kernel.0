From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:47 -0400
Subject: [PATCH 03/37] ARM: mach-kirkwood: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-3-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-kirkwood/include/mach/memory.h |   10 ----------
 2 files changed, 1 insertions(+), 10 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9d5ad30..3fc9d17 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -500,6 +500,7 @@ config ARCH_KIRKWOOD
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select PLAT_ORION
+	select NO_MACH_MEMORY_H
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
 	  88F6180, 88F6192 and 88F6281.
diff --git a/arch/arm/mach-kirkwood/include/mach/memory.h b/arch/arm/mach-kirkwood/include/mach/memory.h
deleted file mode 100644
index 4600b44..0000000
--- a/arch/arm/mach-kirkwood/include/mach/memory.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/include/mach/memory.h
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
