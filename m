From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:16 -0400
Subject: [PATCH 32/37] ARM: mach-vt8500: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-32-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-vt8500/include/mach/memory.h |   28 ----------------------------
 2 files changed, 1 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-vt8500/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 12b07d1..d6b8c92 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -918,6 +918,7 @@ config ARCH_VT8500
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_PWM
+	select NO_MACH_MEMORY_H
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
 endchoice
diff --git a/arch/arm/mach-vt8500/include/mach/memory.h b/arch/arm/mach-vt8500/include/mach/memory.h
deleted file mode 100644
index 175f914..0000000
--- a/arch/arm/mach-vt8500/include/mach/memory.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  arch/arm/mach-vt8500/include/mach/memory.h
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
-/*
- * Physical DRAM offset.
- */
-#define PHYS_OFFSET	UL(0x00000000)
-
-#endif
-- 
1.7.4
