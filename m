From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:01 -0400
Subject: [PATCH 17/37] ARM: mach-nomadik: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-17-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-nomadik/include/mach/memory.h |   28 ---------------------------
 2 files changed, 1 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8a23334..eef880d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -857,6 +857,7 @@ config ARCH_NOMADIK
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
+	select NO_MACH_MEMORY_H
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
diff --git a/arch/arm/mach-nomadik/include/mach/memory.h b/arch/arm/mach-nomadik/include/mach/memory.h
deleted file mode 100644
index d332521..0000000
--- a/arch/arm/mach-nomadik/include/mach/memory.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  mach-nomadik/include/mach/memory.h
- *
- *  Copyright (C) 1999 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-#endif
-- 
1.7.4
