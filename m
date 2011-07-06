From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:04 -0400
Subject: [PATCH 20/37] ARM: mach-netx: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-20-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-netx/include/mach/memory.h |   26 --------------------------
 2 files changed, 1 insertions(+), 26 deletions(-)
 delete mode 100644 arch/arm/mach-netx/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 06bdaf0..95396dc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -412,6 +412,7 @@ config ARCH_NETX
 	select CPU_ARM926T
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
+	select NO_MACH_MEMORY_H
 	help
 	  This enables support for systems based on the Hilscher NetX Soc
 
diff --git a/arch/arm/mach-netx/include/mach/memory.h b/arch/arm/mach-netx/include/mach/memory.h
deleted file mode 100644
index 5956149..0000000
--- a/arch/arm/mach-netx/include/mach/memory.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  arch/arm/mach-netx/include/mach/memory.h
- *
- * Copyright (C) 2005 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
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
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET UL(0x80000000)
-
-#endif
-
-- 
1.7.4
