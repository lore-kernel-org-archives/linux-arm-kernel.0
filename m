From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:57 -0400
Subject: [PATCH 13/37] ARM: mach-vexpress: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-13-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-vexpress/include/mach/memory.h |   25 -------------------------
 2 files changed, 1 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm/mach-vexpress/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 790071c..8690b96 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -300,6 +300,7 @@ config ARCH_VEXPRESS
 	select ICST
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLCD
+	select NO_MACH_MEMORY_H
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
diff --git a/arch/arm/mach-vexpress/include/mach/memory.h b/arch/arm/mach-vexpress/include/mach/memory.h
deleted file mode 100644
index 5b7fcd4..0000000
--- a/arch/arm/mach-vexpress/include/mach/memory.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  arch/arm/mach-vexpress/include/mach/memory.h
- *
- *  Copyright (C) 2003 ARM Limited
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
-#define PLAT_PHYS_OFFSET		UL(0x60000000)
-
-#endif
-- 
1.7.4
