From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:22:46 +0200
Subject: [PATCH 4/7] ARM: shmobile: convert to SPDX identifiers
In-Reply-To: <cover.1538123953.git.horms+renesas@verge.net.au>
References: <cover.1538123953.git.horms+renesas@verge.net.au>
Message-ID: <e2f2594b8e4c4dab5761dede92f3793c34048a6c.1538123953.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig        |  1 +
 arch/arm/mach-shmobile/headsmp-scu.S  | 13 ++-----------
 arch/arm/mach-shmobile/headsmp.S      |  7 ++-----
 arch/arm/mach-shmobile/platsmp-scu.c  |  5 +----
 arch/arm/mach-shmobile/platsmp.c      |  5 +----
 arch/arm/mach-shmobile/pm-rcar-gen2.c |  5 +----
 arch/arm/mach-shmobile/pm-rmobile.c   |  5 +----
 arch/arm/mach-shmobile/pm-rmobile.h   |  7 ++-----
 arch/arm/mach-shmobile/smp-sh73a0.c   | 10 +---------
 arch/arm/mach-shmobile/suspend.c      |  5 +----
 arch/arm/mach-shmobile/timer.c        | 10 +---------
 11 files changed, 14 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 82b8908bec13..cc6ab0dde937 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config PM_RMOBILE
 	bool
 	select PM
diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 936d7011c314..d0234296ae62 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -1,17 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * Shared SCU setup for mach-shmobile
  *
  * Copyright (C) 2012 Bastian Hecht
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index cef8e8c555f8..9466ae61f56a 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * SMP support for R-Mobile / SH-Mobile
  *
  * Copyright (C) 2010  Magnus Damm
  * Copyright (C) 2010  Takashi Yoshii
  *
  * Based on vexpress, Copyright (c) 2003 ARM Limited, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/init.h>
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
index f1a1efde4beb..fcfcef1d1ae4 100644
--- a/arch/arm/mach-shmobile/platsmp-scu.c
+++ b/arch/arm/mach-shmobile/platsmp-scu.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SMP support for SoCs with SCU covered by mach-shmobile
  *
  * Copyright (C) 2013  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/cpu.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index b23378f3d7e1..7437c01513f6 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SMP support for R-Mobile / SH-Mobile
  *
@@ -5,10 +6,6 @@
  * Copyright (C) 2011  Paul Mundt
  *
  * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/init.h>
 #include <asm/cacheflush.h>
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 345af3ebcc3a..2342d7094645 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * R-Car Generation 2 Power management support
  *
  * Copyright (C) 2013 - 2015  Renesas Electronics Corporation
  * Copyright (C) 2011  Renesas Solutions Corp.
  * Copyright (C) 2011  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 9dd6cadcd900..fe6df3fbf455 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * rmobile power management support
  *
@@ -7,10 +8,6 @@
  *
  * based on pm-sh7372.c
  *  Copyright (C) 2011 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/clk/renesas.h>
 #include <linux/console.h>
diff --git a/arch/arm/mach-shmobile/pm-rmobile.h b/arch/arm/mach-shmobile/pm-rmobile.h
index 8146bb6d7237..69f839259b09 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.h
+++ b/arch/arm/mach-shmobile/pm-rmobile.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Copyright (C) 2012 Renesas Solutions Corp.
  *
  * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef PM_RMOBILE_H
 #define PM_RMOBILE_H
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 41137404382e..9bc543faba96 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SMP support for R-Mobile / SH-Mobile - sh73a0 portion
  *
  * Copyright (C) 2010  Magnus Damm
  * Copyright (C) 2010  Takashi Yoshii
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-shmobile/suspend.c b/arch/arm/mach-shmobile/suspend.c
index 74b30bade2c1..3969a499746e 100644
--- a/arch/arm/mach-shmobile/suspend.c
+++ b/arch/arm/mach-shmobile/suspend.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Suspend-to-RAM support code for SH-Mobile ARM
  *
  *  Copyright (C) 2011 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/pm.h>
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 828e8aea037e..7bf25f386e35 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH-Mobile Timer
  *
  * Copyright (C) 2010  Magnus Damm
  * Copyright (C) 2002 - 2009  Paul Mundt
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/clocksource.h>
-- 
2.11.0
