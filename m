From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:40 -0500
Subject: =?UTF-8?q?=5BPATCH=2022/23=5D=20ARM=3A=20big=20removal=20of=20now=20unused=20vmalloc=2Eh=20files?=
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-23-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-at91/include/mach/vmalloc.h       |   28 -----------------------
 arch/arm/mach-bcmring/include/mach/vmalloc.h    |   25 --------------------
 arch/arm/mach-clps711x/include/mach/vmalloc.h   |   20 ----------------
 arch/arm/mach-cns3xxx/include/mach/vmalloc.h    |   11 ---------
 arch/arm/mach-davinci/include/mach/vmalloc.h    |   14 -----------
 arch/arm/mach-dove/include/mach/vmalloc.h       |    5 ----
 arch/arm/mach-ebsa110/include/mach/vmalloc.h    |   10 --------
 arch/arm/mach-ep93xx/include/mach/vmalloc.h     |    5 ----
 arch/arm/mach-exynos/include/mach/vmalloc.h     |   22 ------------------
 arch/arm/mach-footbridge/include/mach/vmalloc.h |   10 --------
 arch/arm/mach-gemini/include/mach/vmalloc.h     |   10 --------
 arch/arm/mach-h720x/include/mach/vmalloc.h      |   10 --------
 arch/arm/mach-highbank/include/mach/vmalloc.h   |    1 -
 arch/arm/mach-integrator/include/mach/vmalloc.h |   20 ----------------
 arch/arm/mach-iop13xx/include/mach/vmalloc.h    |    4 ---
 arch/arm/mach-iop32x/include/mach/vmalloc.h     |    5 ----
 arch/arm/mach-iop33x/include/mach/vmalloc.h     |    5 ----
 arch/arm/mach-ixp2000/include/mach/vmalloc.h    |   20 ----------------
 arch/arm/mach-ixp23xx/include/mach/vmalloc.h    |   10 --------
 arch/arm/mach-ixp4xx/include/mach/vmalloc.h     |    5 ----
 arch/arm/mach-kirkwood/include/mach/vmalloc.h   |    5 ----
 arch/arm/mach-ks8695/include/mach/vmalloc.h     |   19 ---------------
 arch/arm/mach-lpc32xx/include/mach/vmalloc.h    |   24 -------------------
 arch/arm/mach-mmp/include/mach/vmalloc.h        |    5 ----
 arch/arm/mach-msm/include/mach/vmalloc.h        |   22 ------------------
 arch/arm/mach-mv78xx0/include/mach/vmalloc.h    |    5 ----
 arch/arm/mach-mxs/include/mach/vmalloc.h        |   22 ------------------
 arch/arm/mach-netx/include/mach/vmalloc.h       |   19 ---------------
 arch/arm/mach-nomadik/include/mach/vmalloc.h    |    2 -
 arch/arm/mach-omap1/include/mach/vmalloc.h      |   20 ----------------
 arch/arm/mach-omap2/include/mach/vmalloc.h      |   20 ----------------
 arch/arm/mach-orion5x/include/mach/vmalloc.h    |    5 ----
 arch/arm/mach-picoxcell/include/mach/vmalloc.h  |   14 -----------
 arch/arm/mach-pnx4008/include/mach/vmalloc.h    |   20 ----------------
 arch/arm/mach-prima2/include/mach/vmalloc.h     |   16 -------------
 arch/arm/mach-pxa/include/mach/vmalloc.h        |   11 ---------
 arch/arm/mach-realview/include/mach/vmalloc.h   |   21 -----------------
 arch/arm/mach-rpc/include/mach/vmalloc.h        |   10 --------
 arch/arm/mach-s3c2410/include/mach/vmalloc.h    |   20 ----------------
 arch/arm/mach-s3c64xx/include/mach/vmalloc.h    |   20 ----------------
 arch/arm/mach-s5p64x0/include/mach/vmalloc.h    |   20 ----------------
 arch/arm/mach-s5pc100/include/mach/vmalloc.h    |   17 --------------
 arch/arm/mach-s5pv210/include/mach/vmalloc.h    |   22 ------------------
 arch/arm/mach-sa1100/include/mach/vmalloc.h     |    4 ---
 arch/arm/mach-shark/include/mach/vmalloc.h      |    4 ---
 arch/arm/mach-shmobile/include/mach/vmalloc.h   |    7 -----
 arch/arm/mach-spear3xx/include/mach/vmalloc.h   |   19 ---------------
 arch/arm/mach-spear6xx/include/mach/vmalloc.h   |   19 ---------------
 arch/arm/mach-tegra/include/mach/vmalloc.h      |   28 -----------------------
 arch/arm/mach-u300/include/mach/vmalloc.h       |   12 ---------
 arch/arm/mach-ux500/include/mach/vmalloc.h      |   18 --------------
 arch/arm/mach-versatile/include/mach/vmalloc.h  |   21 -----------------
 arch/arm/mach-vexpress/include/mach/vmalloc.h   |   21 -----------------
 arch/arm/mach-vt8500/include/mach/vmalloc.h     |   20 ----------------
 arch/arm/mach-w90x900/include/mach/vmalloc.h    |   23 ------------------
 arch/arm/mach-zynq/include/mach/vmalloc.h       |   20 ----------------
 arch/arm/plat-mxc/include/mach/vmalloc.h        |   22 ------------------
 arch/arm/plat-spear/include/plat/vmalloc.h      |   19 ---------------
 arch/arm/plat-tcc/include/mach/vmalloc.h        |   10 --------
 59 files changed, 0 insertions(+), 866 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-dove/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-h720x/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-msm/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-netx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-realview/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-rpc/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-shark/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-u300/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/vmalloc.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/vmalloc.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/vmalloc.h
 delete mode 100644 arch/arm/plat-spear/include/plat/vmalloc.h
 delete mode 100644 arch/arm/plat-tcc/include/mach/vmalloc.h

diff --git a/arch/arm/mach-at91/include/mach/vmalloc.h b/arch/arm/mach-at91/include/mach/vmalloc.h
deleted file mode 100644
index 8e4a1bd0ab..0000000000
--- a/arch/arm/mach-at91/include/mach/vmalloc.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/vmalloc.h
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
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#include <mach/hardware.h>
-
-#define VMALLOC_END		(AT91_VIRT_BASE & PGDIR_MASK)
-
-#endif
diff --git a/arch/arm/mach-bcmring/include/mach/vmalloc.h b/arch/arm/mach-bcmring/include/mach/vmalloc.h
deleted file mode 100644
index 7397bd7817..0000000000
--- a/arch/arm/mach-bcmring/include/mach/vmalloc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *
- *  Copyright (C) 2000 Russell King.
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
-/*
- * Move VMALLOC_END to 0xf0000000 so that the vm space can range from
- * 0xe0000000 to 0xefffffff. This gives us 256 MB of vm space and handles
- * larger physical memory designs better.
- */
-#define VMALLOC_END       0xf0000000UL
diff --git a/arch/arm/mach-clps711x/include/mach/vmalloc.h b/arch/arm/mach-clps711x/include/mach/vmalloc.h
deleted file mode 100644
index 467b96137e..0000000000
--- a/arch/arm/mach-clps711x/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/vmalloc.h
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
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
-#define VMALLOC_END       0xd0000000UL
diff --git a/arch/arm/mach-cns3xxx/include/mach/vmalloc.h b/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
deleted file mode 100644
index 1dd231d2f7..0000000000
--- a/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * Copyright 2000 Russell King.
- * Copyright 2003 ARM Limited
- * Copyright 2008 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- */
-
-#define VMALLOC_END		0xd8000000UL
diff --git a/arch/arm/mach-davinci/include/mach/vmalloc.h b/arch/arm/mach-davinci/include/mach/vmalloc.h
deleted file mode 100644
index d49646a8e2..0000000000
--- a/arch/arm/mach-davinci/include/mach/vmalloc.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * DaVinci vmalloc definitions
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <mach/hardware.h>
-
-/* Allow vmalloc range until the IO virtual range minus a 2M "hole" */
-#define VMALLOC_END	  (IO_VIRT - (2<<20))
diff --git a/arch/arm/mach-dove/include/mach/vmalloc.h b/arch/arm/mach-dove/include/mach/vmalloc.h
deleted file mode 100644
index a28792cf76..0000000000
--- a/arch/arm/mach-dove/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfd800000UL
diff --git a/arch/arm/mach-ebsa110/include/mach/vmalloc.h b/arch/arm/mach-ebsa110/include/mach/vmalloc.h
deleted file mode 100644
index ea141b7a3e..0000000000
--- a/arch/arm/mach-ebsa110/include/mach/vmalloc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- *  arch/arm/mach-ebsa110/include/mach/vmalloc.h
- *
- *  Copyright (C) 1998 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#define VMALLOC_END       0xdf000000UL
diff --git a/arch/arm/mach-ep93xx/include/mach/vmalloc.h b/arch/arm/mach-ep93xx/include/mach/vmalloc.h
deleted file mode 100644
index 1b3f25d03d..0000000000
--- a/arch/arm/mach-ep93xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-exynos/include/mach/vmalloc.h b/arch/arm/mach-exynos/include/mach/vmalloc.h
deleted file mode 100644
index 284330e571..0000000000
--- a/arch/arm/mach-exynos/include/mach/vmalloc.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* linux/arch/arm/mach-exynos4/include/mach/vmalloc.h
- *
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * Based on arch/arm/mach-s5p6440/include/mach/vmalloc.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * EXYNOS4 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H __FILE__
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-footbridge/include/mach/vmalloc.h b/arch/arm/mach-footbridge/include/mach/vmalloc.h
deleted file mode 100644
index 40ba78e578..0000000000
--- a/arch/arm/mach-footbridge/include/mach/vmalloc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- *  arch/arm/mach-footbridge/include/mach/vmalloc.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-
-#define VMALLOC_END       0xf0000000UL
diff --git a/arch/arm/mach-gemini/include/mach/vmalloc.h b/arch/arm/mach-gemini/include/mach/vmalloc.h
deleted file mode 100644
index 45371eb86f..0000000000
--- a/arch/arm/mach-gemini/include/mach/vmalloc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- *  Copyright (C) 2008-2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#define VMALLOC_END	0xf0000000UL
diff --git a/arch/arm/mach-h720x/include/mach/vmalloc.h b/arch/arm/mach-h720x/include/mach/vmalloc.h
deleted file mode 100644
index 8520b4a4d4..0000000000
--- a/arch/arm/mach-h720x/include/mach/vmalloc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * arch/arm/mach-h720x/include/mach/vmalloc.h
- */
-
-#ifndef __ARCH_ARM_VMALLOC_H
-#define __ARCH_ARM_VMALLOC_H
-
-#define VMALLOC_END       0xd0000000UL
-
-#endif
diff --git a/arch/arm/mach-highbank/include/mach/vmalloc.h b/arch/arm/mach-highbank/include/mach/vmalloc.h
deleted file mode 100644
index 1969e95427..0000000000
--- a/arch/arm/mach-highbank/include/mach/vmalloc.h
+++ /dev/null
@@ -1 +0,0 @@
-#define VMALLOC_END		0xFEE00000UL
diff --git a/arch/arm/mach-integrator/include/mach/vmalloc.h b/arch/arm/mach-integrator/include/mach/vmalloc.h
deleted file mode 100644
index 2f5a2bafb1..0000000000
--- a/arch/arm/mach-integrator/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  arch/arm/mach-integrator/include/mach/vmalloc.h
- *
- *  Copyright (C) 2000 Russell King.
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
-#define VMALLOC_END       0xd0000000UL
diff --git a/arch/arm/mach-iop13xx/include/mach/vmalloc.h b/arch/arm/mach-iop13xx/include/mach/vmalloc.h
deleted file mode 100644
index c534567403..0000000000
--- a/arch/arm/mach-iop13xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef _VMALLOC_H_
-#define _VMALLOC_H_
-#define VMALLOC_END 	0xfa000000UL
-#endif
diff --git a/arch/arm/mach-iop32x/include/mach/vmalloc.h b/arch/arm/mach-iop32x/include/mach/vmalloc.h
deleted file mode 100644
index c4862d48e5..0000000000
--- a/arch/arm/mach-iop32x/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-iop32x/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-iop33x/include/mach/vmalloc.h b/arch/arm/mach-iop33x/include/mach/vmalloc.h
deleted file mode 100644
index 48331dc237..0000000000
--- a/arch/arm/mach-iop33x/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-iop33x/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-ixp2000/include/mach/vmalloc.h b/arch/arm/mach-ixp2000/include/mach/vmalloc.h
deleted file mode 100644
index 61c8dae24f..0000000000
--- a/arch/arm/mach-ixp2000/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-ixp2000/include/mach/vmalloc.h
- *
- * Author: Naeem Afzal <naeem.m.afzal@intel.com>
- *
- * Copyright 2002 Intel Corp.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- * Just any arbitrary offset to the start of the vmalloc VM area: the
- * current 8MB value just means that there will be a 8MB "hole" after the
- * physical memory until the kernel virtual memory starts.  That means that
- * any out-of-bounds memory accesses will hopefully be caught.
- * The vmalloc() routines leaves a hole of 4kB between each vmalloced
- * area for the same reason. ;)
- */
-#define VMALLOC_END	    0xfb000000UL
diff --git a/arch/arm/mach-ixp23xx/include/mach/vmalloc.h b/arch/arm/mach-ixp23xx/include/mach/vmalloc.h
deleted file mode 100644
index 896c56a1c0..0000000000
--- a/arch/arm/mach-ixp23xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * arch/arm/mach-ixp23xx/include/mach/vmalloc.h
- *
- * Copyright (c) 2005 MontaVista Software, Inc.
- *
- * NPU mappings end at 0xf0000000 and we allocate 64MB for board
- * specific static I/O.
- */
-
-#define VMALLOC_END	(0xec000000UL)
diff --git a/arch/arm/mach-ixp4xx/include/mach/vmalloc.h b/arch/arm/mach-ixp4xx/include/mach/vmalloc.h
deleted file mode 100644
index 9bcd64d598..0000000000
--- a/arch/arm/mach-ixp4xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/vmalloc.h
- */
-#define VMALLOC_END       (0xff000000UL)
-
diff --git a/arch/arm/mach-kirkwood/include/mach/vmalloc.h b/arch/arm/mach-kirkwood/include/mach/vmalloc.h
deleted file mode 100644
index bf162ca3d2..0000000000
--- a/arch/arm/mach-kirkwood/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-ks8695/include/mach/vmalloc.h b/arch/arm/mach-ks8695/include/mach/vmalloc.h
deleted file mode 100644
index 744ac66be3..0000000000
--- a/arch/arm/mach-ks8695/include/mach/vmalloc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-ks8695/include/mach/vmalloc.h
- *
- * Copyright (C) 2006 Ben Dooks
- * Copyright (C) 2006 Simtec Electronics <linux@simtec.co.uk>
- *
- * KS8695 vmalloc definition
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	  (KS8695_IO_VA & PGDIR_MASK)
-
-#endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/vmalloc.h b/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
deleted file mode 100644
index 720fa43a60..0000000000
--- a/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * arch/arm/mach-lpc32xx/include/mach/vmalloc.h
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
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	0xF0000000UL
-
-#endif
diff --git a/arch/arm/mach-mmp/include/mach/vmalloc.h b/arch/arm/mach-mmp/include/mach/vmalloc.h
deleted file mode 100644
index 1d0bac003a..0000000000
--- a/arch/arm/mach-mmp/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-msm/include/mach/vmalloc.h b/arch/arm/mach-msm/include/mach/vmalloc.h
deleted file mode 100644
index d138448eff..0000000000
--- a/arch/arm/mach-msm/include/mach/vmalloc.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* arch/arm/mach-msm/include/mach/vmalloc.h
- *
- * Copyright (C) 2007 Google, Inc.
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
-#ifndef __ASM_ARCH_MSM_VMALLOC_H
-#define __ASM_ARCH_MSM_VMALLOC_H
-
-#define VMALLOC_END	  0xd0000000UL
-
-#endif
-
diff --git a/arch/arm/mach-mv78xx0/include/mach/vmalloc.h b/arch/arm/mach-mv78xx0/include/mach/vmalloc.h
deleted file mode 100644
index ba26fe98e6..0000000000
--- a/arch/arm/mach-mv78xx0/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-mxs/include/mach/vmalloc.h b/arch/arm/mach-mxs/include/mach/vmalloc.h
deleted file mode 100644
index 103b0165ed..0000000000
--- a/arch/arm/mach-mxs/include/mach/vmalloc.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright (C) 2000 Russell King.
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
-#ifndef __MACH_MXS_VMALLOC_H__
-#define __MACH_MXS_VMALLOC_H__
-
-/* vmalloc ending address */
-#define VMALLOC_END       0xf4000000UL
-
-#endif /* __MACH_MXS_VMALLOC_H__ */
diff --git a/arch/arm/mach-netx/include/mach/vmalloc.h b/arch/arm/mach-netx/include/mach/vmalloc.h
deleted file mode 100644
index 871f1ef7bf..0000000000
--- a/arch/arm/mach-netx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *  arch/arm/mach-netx/include/mach/vmalloc.h
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
-#define VMALLOC_END       0xd0000000UL
diff --git a/arch/arm/mach-nomadik/include/mach/vmalloc.h b/arch/arm/mach-nomadik/include/mach/vmalloc.h
deleted file mode 100644
index f83d574d94..0000000000
--- a/arch/arm/mach-nomadik/include/mach/vmalloc.h
+++ /dev/null
@@ -1,2 +0,0 @@
-
-#define VMALLOC_END       0xe8000000UL
diff --git a/arch/arm/mach-omap1/include/mach/vmalloc.h b/arch/arm/mach-omap1/include/mach/vmalloc.h
deleted file mode 100644
index 22ec4a4795..0000000000
--- a/arch/arm/mach-omap1/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  arch/arm/mach-omap1/include/mach/vmalloc.h
- *
- *  Copyright (C) 2000 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-#define VMALLOC_END	0xd8000000UL
diff --git a/arch/arm/mach-omap2/include/mach/vmalloc.h b/arch/arm/mach-omap2/include/mach/vmalloc.h
deleted file mode 100644
index 8663199477..0000000000
--- a/arch/arm/mach-omap2/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/vmalloc.h
- *
- *  Copyright (C) 2000 Russell King.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-#define VMALLOC_END	  0xf8000000UL
diff --git a/arch/arm/mach-orion5x/include/mach/vmalloc.h b/arch/arm/mach-orion5x/include/mach/vmalloc.h
deleted file mode 100644
index 06b50aeff7..0000000000
--- a/arch/arm/mach-orion5x/include/mach/vmalloc.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/vmalloc.h
- */
-
-#define VMALLOC_END       0xfd800000UL
diff --git a/arch/arm/mach-picoxcell/include/mach/vmalloc.h b/arch/arm/mach-picoxcell/include/mach/vmalloc.h
deleted file mode 100644
index 0216cc4b1f..0000000000
--- a/arch/arm/mach-picoxcell/include/mach/vmalloc.h
+++ /dev/null
@@ -1,14 +0,0 @@
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
-#define VMALLOC_END	0xfe000000UL
diff --git a/arch/arm/mach-pnx4008/include/mach/vmalloc.h b/arch/arm/mach-pnx4008/include/mach/vmalloc.h
deleted file mode 100644
index 184913c711..0000000000
--- a/arch/arm/mach-pnx4008/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * arch/arm/mach-pnx4008/include/mach/vmalloc.h
- *
- * Author: Vitaly Wool <source@mvista.com>
- *
- * 2006 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-/*
- * Just any arbitrary offset to the start of the vmalloc VM area: the
- * current 8MB value just means that there will be a 8MB "hole" after the
- * physical memory until the kernel virtual memory starts.  That means that
- * any out-of-bounds memory accesses will hopefully be caught.
- * The vmalloc() routines leaves a hole of 4kB between each vmalloced
- * area for the same reason. ;)
- */
-#define VMALLOC_END       0xd0000000UL
diff --git a/arch/arm/mach-prima2/include/mach/vmalloc.h b/arch/arm/mach-prima2/include/mach/vmalloc.h
deleted file mode 100644
index c9f90fec78..0000000000
--- a/arch/arm/mach-prima2/include/mach/vmalloc.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * arch/arm/ach-prima2/include/mach/vmalloc.h
- *
- * Copyright (c) 2010 ? 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef __MACH_VMALLOC_H
-#define __MACH_VMALLOC_H
-
-#include <linux/const.h>
-
-#define VMALLOC_END    _AC(0xFEC00000, UL)
-
-#endif
diff --git a/arch/arm/mach-pxa/include/mach/vmalloc.h b/arch/arm/mach-pxa/include/mach/vmalloc.h
deleted file mode 100644
index bfecfbf5f4..0000000000
--- a/arch/arm/mach-pxa/include/mach/vmalloc.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * arch/arm/mach-pxa/include/mach/vmalloc.h
- *
- * Author:	Nicolas Pitre
- * Copyright:	(C) 2001 MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#define VMALLOC_END       (0xe8000000UL)
diff --git a/arch/arm/mach-realview/include/mach/vmalloc.h b/arch/arm/mach-realview/include/mach/vmalloc.h
deleted file mode 100644
index a2a4c68614..0000000000
--- a/arch/arm/mach-realview/include/mach/vmalloc.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  arch/arm/mach-realview/include/mach/vmalloc.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Russell King.
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
-#define VMALLOC_END		0xf8000000UL
diff --git a/arch/arm/mach-rpc/include/mach/vmalloc.h b/arch/arm/mach-rpc/include/mach/vmalloc.h
deleted file mode 100644
index fb70022863..0000000000
--- a/arch/arm/mach-rpc/include/mach/vmalloc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- *  arch/arm/mach-rpc/include/mach/vmalloc.h
- *
- *  Copyright (C) 1997 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#define VMALLOC_END       0xdc000000UL
diff --git a/arch/arm/mach-s3c2410/include/mach/vmalloc.h b/arch/arm/mach-s3c2410/include/mach/vmalloc.h
deleted file mode 100644
index 7a311e8ddd..0000000000
--- a/arch/arm/mach-s3c2410/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/vmalloc.h
- *
- * from arch/arm/mach-iop3xx/include/mach/vmalloc.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/vmalloc.h b/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
deleted file mode 100644
index 23f75e556a..0000000000
--- a/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* arch/arm/mach-s3c64xx/include/mach/vmalloc.h
- *
- * from arch/arm/mach-iop3xx/include/mach/vmalloc.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C6400 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/vmalloc.h b/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
deleted file mode 100644
index 38dcc71a03..0000000000
--- a/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* linux/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C6400 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/vmalloc.h b/arch/arm/mach-s5pc100/include/mach/vmalloc.h
deleted file mode 100644
index 44c8e5726d..0000000000
--- a/arch/arm/mach-s5pc100/include/mach/vmalloc.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* arch/arm/mach-s5pc100/include/mach/vmalloc.h
- *
- * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C6400 vmalloc definition
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/vmalloc.h b/arch/arm/mach-s5pv210/include/mach/vmalloc.h
deleted file mode 100644
index a6c659d68a..0000000000
--- a/arch/arm/mach-s5pv210/include/mach/vmalloc.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* linux/arch/arm/mach-s5p6442/include/mach/vmalloc.h
- *
- * Copyright 2010 Ben Dooks <ben-linux@fluff.org>
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Based on arch/arm/mach-s5p6442/include/mach/vmalloc.h
- *
- * S5PV210 vmalloc definition
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H __FILE__
-
-#define VMALLOC_END	0xF6000000UL
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-sa1100/include/mach/vmalloc.h b/arch/arm/mach-sa1100/include/mach/vmalloc.h
deleted file mode 100644
index b3d0023984..0000000000
--- a/arch/arm/mach-sa1100/include/mach/vmalloc.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/vmalloc.h
- */
-#define VMALLOC_END       (0xe8000000UL)
diff --git a/arch/arm/mach-shark/include/mach/vmalloc.h b/arch/arm/mach-shark/include/mach/vmalloc.h
deleted file mode 100644
index b10df98852..0000000000
--- a/arch/arm/mach-shark/include/mach/vmalloc.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/vmalloc.h
- */
-#define VMALLOC_END       0xd0000000UL
diff --git a/arch/arm/mach-shmobile/include/mach/vmalloc.h b/arch/arm/mach-shmobile/include/mach/vmalloc.h
deleted file mode 100644
index 2b8fd8b942..0000000000
--- a/arch/arm/mach-shmobile/include/mach/vmalloc.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_VMALLOC_H
-#define __ASM_MACH_VMALLOC_H
-
-/* Vmalloc at ... - 0xe5ffffff */
-#define VMALLOC_END 0xe6000000UL
-
-#endif /* __ASM_MACH_VMALLOC_H */
diff --git a/arch/arm/mach-spear3xx/include/mach/vmalloc.h b/arch/arm/mach-spear3xx/include/mach/vmalloc.h
deleted file mode 100644
index df977b3c9a..0000000000
--- a/arch/arm/mach-spear3xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear3xx/include/mach/vmalloc.h
- *
- * Defining Vmalloc area for SPEAr3xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_VMALLOC_H
-#define __MACH_VMALLOC_H
-
-#include <plat/vmalloc.h>
-
-#endif /* __MACH_VMALLOC_H */
diff --git a/arch/arm/mach-spear6xx/include/mach/vmalloc.h b/arch/arm/mach-spear6xx/include/mach/vmalloc.h
deleted file mode 100644
index 4a0b56cb2a..0000000000
--- a/arch/arm/mach-spear6xx/include/mach/vmalloc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-spear6xx/include/mach/vmalloc.h
- *
- * Defining Vmalloc area for SPEAr6xx machine family
- *
- * Copyright (C) 2009 ST Microelectronics
- * Rajeev Kumar<rajeev-dlh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __MACH_VMALLOC_H
-#define __MACH_VMALLOC_H
-
-#include <plat/vmalloc.h>
-
-#endif	/* __MACH_VMALLOC_H */
diff --git a/arch/arm/mach-tegra/include/mach/vmalloc.h b/arch/arm/mach-tegra/include/mach/vmalloc.h
deleted file mode 100644
index fd6aa65b2d..0000000000
--- a/arch/arm/mach-tegra/include/mach/vmalloc.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/vmalloc.h
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
-#ifndef __MACH_TEGRA_VMALLOC_H
-#define __MACH_TEGRA_VMALLOC_H
-
-#include <asm/sizes.h>
-
-#define VMALLOC_END        0xFE000000UL
-
-#endif
diff --git a/arch/arm/mach-u300/include/mach/vmalloc.h b/arch/arm/mach-u300/include/mach/vmalloc.h
deleted file mode 100644
index ec423b92b8..0000000000
--- a/arch/arm/mach-u300/include/mach/vmalloc.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/vmalloc.h
- *
- *
- * Copyright (C) 2006-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Virtual memory allocations
- * End must be above the I/O registers and on an even 2MiB boundary.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-#define VMALLOC_END	0xfe800000UL
diff --git a/arch/arm/mach-ux500/include/mach/vmalloc.h b/arch/arm/mach-ux500/include/mach/vmalloc.h
deleted file mode 100644
index a4945cb411..0000000000
--- a/arch/arm/mach-ux500/include/mach/vmalloc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  Copyright (C) 2009 ST-Ericsson
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
-#define VMALLOC_END	0xf0000000UL
diff --git a/arch/arm/mach-versatile/include/mach/vmalloc.h b/arch/arm/mach-versatile/include/mach/vmalloc.h
deleted file mode 100644
index 7d8e069ad5..0000000000
--- a/arch/arm/mach-versatile/include/mach/vmalloc.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  arch/arm/mach-versatile/include/mach/vmalloc.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Russell King.
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
-#define VMALLOC_END		0xd8000000UL
diff --git a/arch/arm/mach-vexpress/include/mach/vmalloc.h b/arch/arm/mach-vexpress/include/mach/vmalloc.h
deleted file mode 100644
index f43a36ef67..0000000000
--- a/arch/arm/mach-vexpress/include/mach/vmalloc.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  arch/arm/mach-vexpress/include/mach/vmalloc.h
- *
- *  Copyright (C) 2003 ARM Limited
- *  Copyright (C) 2000 Russell King.
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
-#define VMALLOC_END		0xf8000000UL
diff --git a/arch/arm/mach-vt8500/include/mach/vmalloc.h b/arch/arm/mach-vt8500/include/mach/vmalloc.h
deleted file mode 100644
index 4642290ce4..0000000000
--- a/arch/arm/mach-vt8500/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  arch/arm/mach-vt8500/include/mach/vmalloc.h
- *
- *  Copyright (C) 2000 Russell King.
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
-#define VMALLOC_END	0xd0000000UL
diff --git a/arch/arm/mach-w90x900/include/mach/vmalloc.h b/arch/arm/mach-w90x900/include/mach/vmalloc.h
deleted file mode 100644
index b067e44500..0000000000
--- a/arch/arm/mach-w90x900/include/mach/vmalloc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * arch/arm/mach-w90x900/include/mach/vmalloc.h
- *
- * Copyright (c) 2008 Nuvoton technology corporation
- * All rights reserved.
- *
- * Wan ZongShun <mcuos.com@gmail.com>
- *
- * Based on arch/arm/mach-s3c2410/include/mach/vmalloc.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-
-#ifndef __ASM_ARCH_VMALLOC_H
-#define __ASM_ARCH_VMALLOC_H
-
-#define VMALLOC_END	  (0xe0000000UL)
-
-#endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-zynq/include/mach/vmalloc.h b/arch/arm/mach-zynq/include/mach/vmalloc.h
deleted file mode 100644
index 2398eff1e8..0000000000
--- a/arch/arm/mach-zynq/include/mach/vmalloc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* arch/arm/mach-zynq/include/mach/vmalloc.h
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
-#ifndef __MACH_VMALLOC_H__
-#define __MACH_VMALLOC_H__
-
-#define VMALLOC_END       0xE0000000UL
-
-#endif
diff --git a/arch/arm/plat-mxc/include/mach/vmalloc.h b/arch/arm/plat-mxc/include/mach/vmalloc.h
deleted file mode 100644
index ef6379c474..0000000000
--- a/arch/arm/plat-mxc/include/mach/vmalloc.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright (C) 2000 Russell King.
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
-#ifndef __ASM_ARCH_MXC_VMALLOC_H__
-#define __ASM_ARCH_MXC_VMALLOC_H__
-
-/* vmalloc ending address */
-#define VMALLOC_END       0xf4000000UL
-
-#endif /* __ASM_ARCH_MXC_VMALLOC_H__ */
diff --git a/arch/arm/plat-spear/include/plat/vmalloc.h b/arch/arm/plat-spear/include/plat/vmalloc.h
deleted file mode 100644
index 8c8b24d070..0000000000
--- a/arch/arm/plat-spear/include/plat/vmalloc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/vmalloc.h
- *
- * Defining Vmalloc area for SPEAr platform
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar<viresh.kumar@st.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __PLAT_VMALLOC_H
-#define __PLAT_VMALLOC_H
-
-#define VMALLOC_END		0xF0000000UL
-
-#endif /* __PLAT_VMALLOC_H */
diff --git a/arch/arm/plat-tcc/include/mach/vmalloc.h b/arch/arm/plat-tcc/include/mach/vmalloc.h
deleted file mode 100644
index 99414d9c2b..0000000000
--- a/arch/arm/plat-tcc/include/mach/vmalloc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * Author: <linux@telechips.com>
- * Created: June 10, 2008
- *
- * Copyright (C) 2000 Russell King.
- * Copyright (C) 2008-2009 Telechips
- *
- * Licensed under the terms of the GPL v2.
- */
-#define VMALLOC_END	0xf0000000UL
-- 
1.7.7.1.431.g10b2a
