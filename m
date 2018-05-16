From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 16 May 2018 16:19:23 +0800
Subject: [PATCH] ARM: berlin: switch to SPDX license identifier
Message-ID: <20180516161923.2a39d8f2@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the appropriate SPDX license identifier and drop the previous
boilerplate license text.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mach-berlin/berlin.c  | 5 +----
 arch/arm/mach-berlin/headsmp.S | 5 +----
 arch/arm/mach-berlin/platsmp.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index ac181c6797ee..2424ad40190c 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device Tree support for Marvell Berlin SoCs.
  *
@@ -5,10 +6,6 @@
  *
  * based on GPL'ed 2.6 kernel sources
  *  (c) Marvell International Ltd.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/arch/arm/mach-berlin/headsmp.S b/arch/arm/mach-berlin/headsmp.S
index dc82a3486b05..3057885d9772 100644
--- a/arch/arm/mach-berlin/headsmp.S
+++ b/arch/arm/mach-berlin/headsmp.S
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine T?nart <antoine.tenart@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index a8ae4a566d99..593fc4a69d84 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine T?nart <antoine.tenart@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/io.h>
-- 
2.17.0
