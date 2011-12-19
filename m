From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:49 -0500
Subject: [PATCH 20/20] ARM: big removal of now unused arch_reset()
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-21-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When this is the only content remaining in mach/system.h then the
whole file is removed.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-at91/include/mach/system.h       |   29 ---------------------
 arch/arm/mach-bcmring/include/mach/system.h    |   28 --------------------
 arch/arm/mach-clps711x/include/mach/system.h   |   32 -----------------------
 arch/arm/mach-cns3xxx/include/mach/system.h    |   25 ------------------
 arch/arm/mach-davinci/include/mach/system.h    |   21 ---------------
 arch/arm/mach-dove/include/mach/system.h       |   17 ------------
 arch/arm/mach-ebsa110/include/mach/system.h    |   18 -------------
 arch/arm/mach-ep93xx/include/mach/system.h     |    7 -----
 arch/arm/mach-exynos/include/mach/system.h     |   22 ----------------
 arch/arm/mach-footbridge/include/mach/system.h |   13 ---------
 arch/arm/mach-gemini/include/mach/system.h     |   22 ----------------
 arch/arm/mach-h720x/include/mach/system.h      |   22 ----------------
 arch/arm/mach-highbank/include/mach/system.h   |   24 -----------------
 arch/arm/mach-integrator/include/mach/system.h |   33 ------------------------
 arch/arm/mach-iop13xx/include/mach/system.h    |   13 ---------
 arch/arm/mach-iop32x/include/mach/system.h     |   13 ---------
 arch/arm/mach-iop33x/include/mach/system.h     |   13 ---------
 arch/arm/mach-ixp2000/include/mach/system.h    |   14 ----------
 arch/arm/mach-ixp23xx/include/mach/system.h    |   13 ---------
 arch/arm/mach-ixp4xx/include/mach/system.h     |   14 ----------
 arch/arm/mach-kirkwood/include/mach/system.h   |   17 ------------
 arch/arm/mach-ks8695/include/mach/system.h     |   27 -------------------
 arch/arm/mach-lpc32xx/include/mach/system.h    |   27 -------------------
 arch/arm/mach-mmp/include/mach/system.h        |   16 -----------
 arch/arm/mach-msm/include/mach/system.h        |    4 ---
 arch/arm/mach-mv78xx0/include/mach/system.h    |   17 ------------
 arch/arm/mach-mxs/include/mach/system.h        |   25 ------------------
 arch/arm/mach-netx/include/mach/system.h       |   28 --------------------
 arch/arm/mach-nomadik/include/mach/system.h    |   32 -----------------------
 arch/arm/mach-omap1/include/mach/system.h      |    5 ---
 arch/arm/mach-omap2/include/mach/system.h      |    5 ---
 arch/arm/mach-orion5x/include/mach/system.h    |   19 -------------
 arch/arm/mach-picoxcell/include/mach/system.h  |   26 ------------------
 arch/arm/mach-pnx4008/include/mach/system.h    |   29 ---------------------
 arch/arm/mach-prima2/include/mach/system.h     |   17 ------------
 arch/arm/mach-pxa/include/mach/system.h        |   15 -----------
 arch/arm/mach-realview/include/mach/system.h   |   33 ------------------------
 arch/arm/mach-rpc/include/mach/system.h        |   13 ---------
 arch/arm/mach-s3c2410/include/mach/system.h    |    5 ---
 arch/arm/mach-s3c64xx/include/mach/system.h    |    5 ---
 arch/arm/mach-s5p64x0/include/mach/system.h    |   23 ----------------
 arch/arm/mach-s5pc100/include/mach/system.h    |   21 ---------------
 arch/arm/mach-s5pv210/include/mach/system.h    |   23 ----------------
 arch/arm/mach-sa1100/include/mach/system.h     |    9 ------
 arch/arm/mach-shark/include/mach/system.h      |   14 ----------
 arch/arm/mach-shmobile/include/mach/system.h   |    5 ---
 arch/arm/mach-spear3xx/include/mach/system.h   |   19 -------------
 arch/arm/mach-spear6xx/include/mach/system.h   |   19 -------------
 arch/arm/mach-tegra/include/mach/system.h      |   29 ---------------------
 arch/arm/mach-u300/include/mach/system.h       |   14 ----------
 arch/arm/mach-ux500/include/mach/system.h      |   20 --------------
 arch/arm/mach-versatile/include/mach/system.h  |   33 ------------------------
 arch/arm/mach-vexpress/include/mach/system.h   |   33 ------------------------
 arch/arm/mach-vt8500/include/mach/system.h     |    5 ---
 arch/arm/mach-w90x900/include/mach/system.h    |   20 --------------
 arch/arm/mach-zynq/include/mach/system.h       |   23 ----------------
 arch/arm/plat-mxc/include/mach/system.h        |   25 ------------------
 arch/arm/plat-omap/include/plat/system.h       |   15 -----------
 arch/arm/plat-spear/include/plat/system.h      |   26 ------------------
 arch/arm/plat-tcc/include/mach/system.h        |   31 ----------------------
 60 files changed, 0 insertions(+), 1165 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/system.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/system.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/system.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/system.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/system.h
 delete mode 100644 arch/arm/mach-dove/include/mach/system.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/system.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/system.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/system.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/system.h
 delete mode 100644 arch/arm/mach-h720x/include/mach/system.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/system.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/system.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/system.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/system.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/system.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/system.h
 delete mode 100644 arch/arm/mach-netx/include/mach/system.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/system.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/system.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/system.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/system.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/system.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/system.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/system.h
 delete mode 100644 arch/arm/mach-realview/include/mach/system.h
 delete mode 100644 arch/arm/mach-rpc/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/system.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/system.h
 delete mode 100644 arch/arm/mach-shark/include/mach/system.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/system.h
 delete mode 100644 arch/arm/mach-u300/include/mach/system.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/system.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/system.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/system.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/system.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/system.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/system.h
 delete mode 100644 arch/arm/plat-omap/include/plat/system.h
 delete mode 100644 arch/arm/plat-spear/include/plat/system.h
 delete mode 100644 arch/arm/plat-tcc/include/mach/system.h

diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
deleted file mode 100644
index ba85c441ca..0000000000
--- a/arch/arm/mach-at91/include/mach/system.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/system.h
- *
- *  Copyright (C) 2003 SAN People
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
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-bcmring/include/mach/system.h b/arch/arm/mach-bcmring/include/mach/system.h
deleted file mode 100644
index cb78250db6..0000000000
--- a/arch/arm/mach-bcmring/include/mach/system.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
deleted file mode 100644
index 0e74e1e9cc..0000000000
--- a/arch/arm/mach-clps711x/include/mach/system.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/system.h
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <asm/hardware/clps7111.h>
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-cns3xxx/include/mach/system.h b/arch/arm/mach-cns3xxx/include/mach/system.h
deleted file mode 100644
index 9e56b7dc13..0000000000
--- a/arch/arm/mach-cns3xxx/include/mach/system.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright 2000 Deep Blue Solutions Ltd
- * Copyright 2003 ARM Limited
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_SYSTEM_H
-#define __MACH_SYSTEM_H
-
-#include <asm/proc-fns.h>
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
deleted file mode 100644
index fcb7a015ab..0000000000
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * DaVinci system defines
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-#include <mach/common.h>
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-dove/include/mach/system.h b/arch/arm/mach-dove/include/mach/system.h
deleted file mode 100644
index 3027954f61..0000000000
--- a/arch/arm/mach-dove/include/mach/system.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/system.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-ebsa110/include/mach/system.h b/arch/arm/mach-ebsa110/include/mach/system.h
deleted file mode 100644
index b4601699b3..0000000000
--- a/arch/arm/mach-ebsa110/include/mach/system.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  arch/arm/mach-ebsa110/include/mach/system.h
- *
- *  Copyright (C) 1996-2000 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
deleted file mode 100644
index b5bec7cb9b..0000000000
--- a/arch/arm/mach-ep93xx/include/mach/system.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/system.h
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-exynos/include/mach/system.h b/arch/arm/mach-exynos/include/mach/system.h
deleted file mode 100644
index 4d5a9d73fb..0000000000
--- a/arch/arm/mach-exynos/include/mach/system.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/system.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 - system support header
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H __FILE__
-
-#include <plat/system-reset.h>
-
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-footbridge/include/mach/system.h b/arch/arm/mach-footbridge/include/mach/system.h
deleted file mode 100644
index a174a5841b..0000000000
--- a/arch/arm/mach-footbridge/include/mach/system.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *  arch/arm/mach-footbridge/include/mach/system.h
- *
- *  Copyright (C) 1996-1999 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-gemini/include/mach/system.h b/arch/arm/mach-gemini/include/mach/system.h
deleted file mode 100644
index 1bb2734e73..0000000000
--- a/arch/arm/mach-gemini/include/mach/system.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright (C) 2001-2006 Storlink, Corp.
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef __MACH_SYSTEM_H
-#define __MACH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-}
-
-#endif /* __MACH_SYSTEM_H */
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
deleted file mode 100644
index 008ed164b2..0000000000
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-h720x/include/mach/system.h
- *
- * Copyright (C) 2001-2002 Jungjun Kim, Hynix Semiconductor Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- * arch/arm/mach-h720x/include/mach/system.h
- *
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-#include <mach/hardware.h>
-
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-highbank/include/mach/system.h b/arch/arm/mach-highbank/include/mach/system.h
deleted file mode 100644
index b1d8b5fbe3..0000000000
--- a/arch/arm/mach-highbank/include/mach/system.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright 2010-2011 Calxeda, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __MACH_SYSTEM_H
-#define __MACH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-integrator/include/mach/system.h b/arch/arm/mach-integrator/include/mach/system.h
deleted file mode 100644
index 901514eba4..0000000000
--- a/arch/arm/mach-integrator/include/mach/system.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/mach-integrator/include/mach/system.h
- *
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-iop13xx/include/mach/system.h b/arch/arm/mach-iop13xx/include/mach/system.h
deleted file mode 100644
index 1f31ed3f8a..0000000000
--- a/arch/arm/mach-iop13xx/include/mach/system.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-iop13xx/include/mach/system.h
- *
- *  Copyright (C) 2004 Intel Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
deleted file mode 100644
index 4a88727bca..0000000000
--- a/arch/arm/mach-iop32x/include/mach/system.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-iop32x/include/mach/system.h
- *
- * Copyright (C) 2001 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-iop33x/include/mach/system.h b/arch/arm/mach-iop33x/include/mach/system.h
deleted file mode 100644
index 4f98e76539..0000000000
--- a/arch/arm/mach-iop33x/include/mach/system.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-iop33x/include/mach/system.h
- *
- * Copyright (C) 2001 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-ixp2000/include/mach/system.h b/arch/arm/mach-ixp2000/include/mach/system.h
deleted file mode 100644
index a7fb08b2b8..0000000000
--- a/arch/arm/mach-ixp2000/include/mach/system.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-ixp2000/include/mach/system.h
- *
- * Copyright (C) 2002 Intel Corp.
- * Copyricht (C) 2003-2005 MontaVista Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
deleted file mode 100644
index 69f80006fc..0000000000
--- a/arch/arm/mach-ixp23xx/include/mach/system.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-ixp23xx/include/mach/system.h
- *
- * Copyright (C) 2003 Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
deleted file mode 100644
index 768ac09d0f..0000000000
--- a/arch/arm/mach-ixp4xx/include/mach/system.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/system.h
- *
- * Copyright (C) 2002 Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-kirkwood/include/mach/system.h b/arch/arm/mach-kirkwood/include/mach/system.h
deleted file mode 100644
index 5fddde002b..0000000000
--- a/arch/arm/mach-kirkwood/include/mach/system.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/include/mach/system.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-ks8695/include/mach/system.h b/arch/arm/mach-ks8695/include/mach/system.h
deleted file mode 100644
index 59fe992395..0000000000
--- a/arch/arm/mach-ks8695/include/mach/system.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * arch/arm/mach-s3c2410/include/mach/system.h
- *
- * Copyright (C) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * KS8695 - System function defines and includes
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks,
-	 */
-	cpu_do_idle();
-
-}
-
-#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
deleted file mode 100644
index bf176c9915..0000000000
--- a/arch/arm/mach-lpc32xx/include/mach/system.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/include/mach/system.h
- *
- * Author: Kevin Wells <kevin.wells@nxp.com>
- *
- * Copyright (C) 2010 NXP Semiconductors
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
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
deleted file mode 100644
index 1d001eab81..0000000000
--- a/arch/arm/mach-mmp/include/mach/system.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/system.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_MACH_SYSTEM_H
-#define __ASM_MACH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-#endif /* __ASM_MACH_SYSTEM_H */
diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
index f2c049526b..f5fb2ec87f 100644
--- a/arch/arm/mach-msm/include/mach/system.h
+++ b/arch/arm/mach-msm/include/mach/system.h
@@ -12,10 +12,6 @@
  * GNU General Public License for more details.
  *
  */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
 
 /* low level hardware reset hook -- for example, hitting the
  * PSHOLD line on the PMIC to hard reset the system
diff --git a/arch/arm/mach-mv78xx0/include/mach/system.h b/arch/arm/mach-mv78xx0/include/mach/system.h
deleted file mode 100644
index 8c3a5387ce..0000000000
--- a/arch/arm/mach-mv78xx0/include/mach/system.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/system.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-mxs/include/mach/system.h b/arch/arm/mach-mxs/include/mach/system.h
deleted file mode 100644
index e7ad1bb294..0000000000
--- a/arch/arm/mach-mxs/include/mach/system.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
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
- */
-
-#ifndef __MACH_MXS_SYSTEM_H__
-#define __MACH_MXS_SYSTEM_H__
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif /* __MACH_MXS_SYSTEM_H__ */
diff --git a/arch/arm/mach-netx/include/mach/system.h b/arch/arm/mach-netx/include/mach/system.h
deleted file mode 100644
index b38fa36d58..0000000000
--- a/arch/arm/mach-netx/include/mach/system.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-netx/include/mach/system.h
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
-
diff --git a/arch/arm/mach-nomadik/include/mach/system.h b/arch/arm/mach-nomadik/include/mach/system.h
deleted file mode 100644
index 25e198b897..0000000000
--- a/arch/arm/mach-nomadik/include/mach/system.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *  mach-nomadik/include/mach/system.h
- *
- *  Copyright (C) 2008 STMicroelectronics
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-omap1/include/mach/system.h b/arch/arm/mach-omap1/include/mach/system.h
deleted file mode 100644
index a6c1b3a16d..0000000000
--- a/arch/arm/mach-omap1/include/mach/system.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/system.h
- */
-
-#include <plat/system.h>
diff --git a/arch/arm/mach-omap2/include/mach/system.h b/arch/arm/mach-omap2/include/mach/system.h
deleted file mode 100644
index d488721ab9..0000000000
--- a/arch/arm/mach-omap2/include/mach/system.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/system.h
- */
-
-#include <plat/system.h>
diff --git a/arch/arm/mach-orion5x/include/mach/system.h b/arch/arm/mach-orion5x/include/mach/system.h
deleted file mode 100644
index 825a2650ce..0000000000
--- a/arch/arm/mach-orion5x/include/mach/system.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/system.h
- *
- * Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-picoxcell/include/mach/system.h b/arch/arm/mach-picoxcell/include/mach/system.h
deleted file mode 100644
index 1a5d8cb57d..0000000000
--- a/arch/arm/mach-picoxcell/include/mach/system.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
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
- */
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching and wait for interrupt
-	 * tricks.
-	 */
-	cpu_do_idle();
-}
-
-#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-pnx4008/include/mach/system.h b/arch/arm/mach-pnx4008/include/mach/system.h
deleted file mode 100644
index 60cfe71880..0000000000
--- a/arch/arm/mach-pnx4008/include/mach/system.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * arch/arm/mach-pnx4008/include/mach/system.h
- *
- * Copyright (C) 2003 Philips Semiconductors
- * Copyright (C) 2005 MontaVista Software, Inc.
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-prima2/include/mach/system.h b/arch/arm/mach-prima2/include/mach/system.h
deleted file mode 100644
index 2c7d2a9d0c..0000000000
--- a/arch/arm/mach-prima2/include/mach/system.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/arm/mach-prima2/include/mach/system.h
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_SYSTEM_H__
-#define __MACH_SYSTEM_H__
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-pxa/include/mach/system.h b/arch/arm/mach-pxa/include/mach/system.h
deleted file mode 100644
index c5afacd3cc..0000000000
--- a/arch/arm/mach-pxa/include/mach/system.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * arch/arm/mach-pxa/include/mach/system.h
- *
- * Author:	Nicolas Pitre
- * Created:	Jun 15, 2001
- * Copyright:	MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-realview/include/mach/system.h b/arch/arm/mach-realview/include/mach/system.h
deleted file mode 100644
index 471b671159..0000000000
--- a/arch/arm/mach-realview/include/mach/system.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/mach-realview/include/mach/system.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-rpc/include/mach/system.h b/arch/arm/mach-rpc/include/mach/system.h
deleted file mode 100644
index 359bab94b6..0000000000
--- a/arch/arm/mach-rpc/include/mach/system.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *  arch/arm/mach-rpc/include/mach/system.h
- *
- *  Copyright (C) 1996-1999 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-s3c2410/include/mach/system.h b/arch/arm/mach-s3c2410/include/mach/system.h
index 0cff890b9b..e537fdc59a 100644
--- a/arch/arm/mach-s3c2410/include/mach/system.h
+++ b/arch/arm/mach-s3c2410/include/mach/system.h
@@ -18,9 +18,4 @@
 
 void (*s3c24xx_reset_hook)(void);
 
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
 #include <mach/system-reset.h>
diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
index 0868f26c83..8a9e93a547 100644
--- a/arch/arm/mach-s3c64xx/include/mach/system.h
+++ b/arch/arm/mach-s3c64xx/include/mach/system.h
@@ -13,11 +13,6 @@
 
 #include <plat/watchdog-reset.h>
 
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
 static void arch_reset(char mode, const char *cmd)
 {
 	if (mode != 's')
diff --git a/arch/arm/mach-s5p64x0/include/mach/system.h b/arch/arm/mach-s5p64x0/include/mach/system.h
deleted file mode 100644
index 60f57532c9..0000000000
--- a/arch/arm/mach-s5p64x0/include/mach/system.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/system.h
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5P64X0 - system support header
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H __FILE__
-
-#include <plat/system-reset.h>
-
-static void arch_idle(void)
-{
-	/* nothing here yet */
-}
-
-#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-s5pc100/include/mach/system.h
deleted file mode 100644
index ebfeb943f5..0000000000
--- a/arch/arm/mach-s5pc100/include/mach/system.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/system.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *      Byungho Min <bhmin@samsung.com>
- *
- * S5PC100 - system implementation
- *
- * Based on mach-s3c6400/include/mach/system.h
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H __FILE__
-
-#include <plat/system-reset.h>
-
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/system.h b/arch/arm/mach-s5pv210/include/mach/system.h
deleted file mode 100644
index 0c1cb1f327..0000000000
--- a/arch/arm/mach-s5pv210/include/mach/system.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/system.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5PV210 - system support header
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H __FILE__
-
-#include <plat/system-reset.h>
-
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-sa1100/include/mach/system.h b/arch/arm/mach-sa1100/include/mach/system.h
deleted file mode 100644
index e17b208f76..0000000000
--- a/arch/arm/mach-sa1100/include/mach/system.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/system.h
- *
- * Copyright (c) 1999 Nicolas Pitre <nico@fluxnic.net>
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-shark/include/mach/system.h b/arch/arm/mach-shark/include/mach/system.h
deleted file mode 100644
index 1ec8d6c383..0000000000
--- a/arch/arm/mach-shark/include/mach/system.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/system.h
- *
- * by Alexander Schulz
- */
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
index 956ac18ddb..3bbcb3fa07 100644
--- a/arch/arm/mach-shmobile/include/mach/system.h
+++ b/arch/arm/mach-shmobile/include/mach/system.h
@@ -1,11 +1,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
 static inline void arch_reset(char mode, const char *cmd)
 {
 	soft_restart(0);
diff --git a/arch/arm/mach-spear3xx/include/mach/system.h b/arch/arm/mach-spear3xx/include/mach/system.h
deleted file mode 100644
index 92cee6335c..0000000000
--- a/arch/arm/mach-spear3xx/include/mach/system.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/system.h
- *
- * SPEAr3xx Machine family specific architecture functions
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_SYSTEM_H
-#define __MACH_SYSTEM_H
-
-#include <plat/system.h>
-
-#endif /* __MACH_SYSTEM_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/system.h b/arch/arm/mach-spear6xx/include/mach/system.h
deleted file mode 100644
index 0b1d2be81c..0000000000
--- a/arch/arm/mach-spear6xx/include/mach/system.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/system.h
- *
- * SPEAr6xx Machine family specific architecture functions
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_SYSTEM_H
-#define __MACH_SYSTEM_H
-
-#include <plat/system.h>
-
-#endif	/* __MACH_SYSTEM_H */
diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
deleted file mode 100644
index 968ea2b052..0000000000
--- a/arch/arm/mach-tegra/include/mach/system.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/system.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *	Erik Gilling <konkers@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_SYSTEM_H
-#define __MACH_TEGRA_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-u300/include/mach/system.h b/arch/arm/mach-u300/include/mach/system.h
deleted file mode 100644
index 574d46e382..0000000000
--- a/arch/arm/mach-u300/include/mach/system.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/system.h
- *
- *
- * Copyright (C) 2007-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * System shutdown and reset functions.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-ux500/include/mach/system.h b/arch/arm/mach-ux500/include/mach/system.h
deleted file mode 100644
index 258e5c919c..0000000000
--- a/arch/arm/mach-ux500/include/mach/system.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2009 ST-Ericsson.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-versatile/include/mach/system.h b/arch/arm/mach-versatile/include/mach/system.h
deleted file mode 100644
index f3fa347895..0000000000
--- a/arch/arm/mach-versatile/include/mach/system.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/system.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-vexpress/include/mach/system.h b/arch/arm/mach-vexpress/include/mach/system.h
deleted file mode 100644
index f653a8e265..0000000000
--- a/arch/arm/mach-vexpress/include/mach/system.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/mach-vexpress/include/mach/system.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
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
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/mach-vt8500/include/mach/system.h b/arch/arm/mach-vt8500/include/mach/system.h
index d6c757eaf2..58fa8010ee 100644
--- a/arch/arm/mach-vt8500/include/mach/system.h
+++ b/arch/arm/mach-vt8500/include/mach/system.h
@@ -7,11 +7,6 @@
 /* PM Software Reset request register */
 #define VT8500_PMSR_VIRT	0xf8130060
 
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
 static inline void arch_reset(char mode, const char *cmd)
 {
 	writel(1, VT8500_PMSR_VIRT);
diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
deleted file mode 100644
index f713161ee5..0000000000
--- a/arch/arm/mach-w90x900/include/mach/system.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-w90x900/include/mach/system.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- *
- * Based on arch/arm/mach-s3c2410/include/mach/system.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-static void arch_idle(void)
-{
-	cpu_do_idle();
-}
diff --git a/arch/arm/mach-zynq/include/mach/system.h b/arch/arm/mach-zynq/include/mach/system.h
deleted file mode 100644
index 8e88e0b8d2..0000000000
--- a/arch/arm/mach-zynq/include/mach/system.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* arch/arm/mach-zynq/include/mach/system.h
- *
- *  Copyright (C) 2011 Xilinx
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __MACH_SYSTEM_H__
-#define __MACH_SYSTEM_H__
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
deleted file mode 100644
index 13ad0df2e8..0000000000
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright 2004-2008 Freescale Semiconductor, Inc. All Rights Reserved.
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
- */
-
-#ifndef __ASM_ARCH_MXC_SYSTEM_H__
-#define __ASM_ARCH_MXC_SYSTEM_H__
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif /* __ASM_ARCH_MXC_SYSTEM_H__ */
diff --git a/arch/arm/plat-omap/include/plat/system.h b/arch/arm/plat-omap/include/plat/system.h
deleted file mode 100644
index 8e5ebd74b1..0000000000
--- a/arch/arm/plat-omap/include/plat/system.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copied from arch/arm/mach-sa1100/include/mach/system.h
- * Copyright (c) 1999 Nicolas Pitre <nico@fluxnic.net>
- */
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-
-#include <asm/proc-fns.h>
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-#endif
diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
deleted file mode 100644
index 86c6f83b44..0000000000
--- a/arch/arm/plat-spear/include/plat/system.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/system.h
- *
- * SPEAr platform specific architecture functions
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_SYSTEM_H
-#define __PLAT_SYSTEM_H
-
-static inline void arch_idle(void)
-{
-	/*
-	 * This should do all the clock switching
-	 * and wait for interrupt tricks
-	 */
-	cpu_do_idle();
-}
-
-#endif /* __PLAT_SYSTEM_H */
diff --git a/arch/arm/plat-tcc/include/mach/system.h b/arch/arm/plat-tcc/include/mach/system.h
deleted file mode 100644
index 9adf36f9e8..0000000000
--- a/arch/arm/plat-tcc/include/mach/system.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Author: <linux@telechips.com>
- * Created: June 10, 2008
- * Description: LINUX SYSTEM FUNCTIONS for TCC83x
- *
- * Copyright (C) 2008-2009 Telechips
- *
- * Licensed under the terms of the GPL v2.
- *
- */
-
-#ifndef __ASM_ARCH_SYSTEM_H
-#define __ASM_ARCH_SYSTEM_H
-#include <linux/clk.h>
-
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-
-extern void plat_tcc_restart(char mode, const char *cmd);
-
-static inline void arch_idle(void)
-{
-	cpu_do_idle();
-}
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-	plat_tcc_restart(mode, cmd);
-}
-
-#endif
-- 
1.7.7.1.431.g10b2a
