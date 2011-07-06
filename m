From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:09 -0400
Subject: [PATCH 25/37] ARM: mach-mxs: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-25-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-mxs/include/mach/memory.h |   24 ------------------------
 2 files changed, 1 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 755a85d..a2e96e8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -404,6 +404,7 @@ config ARCH_MXS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Freescale MXS-based family of processors
 
diff --git a/arch/arm/mach-mxs/include/mach/memory.h b/arch/arm/mach-mxs/include/mach/memory.h
deleted file mode 100644
index b5420a5..0000000
--- a/arch/arm/mach-mxs/include/mach/memory.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
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
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef __MACH_MXS_MEMORY_H__
-#define __MACH_MXS_MEMORY_H__
-
-#define PHYS_OFFSET		UL(0x40000000)
-
-#endif /* __MACH_MXS_MEMORY_H__ */
-- 
1.7.4
