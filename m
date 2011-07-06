From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:49 -0400
Subject: [PATCH 05/37] ARM: mach-orion5x: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-orion5x/include/mach/memory.h |   12 ------------
 2 files changed, 1 insertions(+), 12 deletions(-)
 delete mode 100644 arch/arm/mach-orion5x/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fd6d633..e8004b4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -547,6 +547,7 @@ config ARCH_ORION5X
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select PLAT_ORION
+	select NO_MACH_MEMORY_H
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
diff --git a/arch/arm/mach-orion5x/include/mach/memory.h b/arch/arm/mach-orion5x/include/mach/memory.h
deleted file mode 100644
index 6769917..0000000
--- a/arch/arm/mach-orion5x/include/mach/memory.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/memory.h
- *
- * Marvell Orion memory definitions
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
