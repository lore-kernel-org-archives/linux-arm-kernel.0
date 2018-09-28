From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:22 +0200
Subject: [PATCH 07/21] soc: renesas: convert to SPDX identifiers
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <41c4567ce2610b7a87952398756d662e979621fa.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Kconfig         |  1 +
 drivers/soc/renesas/r8a7743-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7745-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7779-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7790-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7791-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7792-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7794-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7795-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7796-sysc.c  |  5 +----
 drivers/soc/renesas/r8a77970-sysc.c |  5 +----
 drivers/soc/renesas/r8a77995-sysc.c |  5 +----
 drivers/soc/renesas/rcar-rst.c      |  5 +----
 drivers/soc/renesas/rcar-sysc.c     |  5 +----
 drivers/soc/renesas/rcar-sysc.h     |  7 ++-----
 drivers/soc/renesas/renesas-soc.c   | 10 +---------
 16 files changed, 17 insertions(+), 66 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 00d4c9db1981..4ba59783e607 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config SOC_RENESAS
 	bool "Renesas SoC driver support" if COMPILE_TEST && !ARCH_RENESAS
 	default y if ARCH_RENESAS
diff --git a/drivers/soc/renesas/r8a7743-sysc.c b/drivers/soc/renesas/r8a7743-sysc.c
index 9583a327d90c..edf6436e879f 100644
--- a/drivers/soc/renesas/r8a7743-sysc.c
+++ b/drivers/soc/renesas/r8a7743-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas RZ/G1M System Controller
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation; of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7745-sysc.c b/drivers/soc/renesas/r8a7745-sysc.c
index d17887c08aa1..65dc6b09cc85 100644
--- a/drivers/soc/renesas/r8a7745-sysc.c
+++ b/drivers/soc/renesas/r8a7745-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas RZ/G1E System Controller
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation; of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7779-sysc.c b/drivers/soc/renesas/r8a7779-sysc.c
index 9e8e6b7faa04..517aa40fa6e6 100644
--- a/drivers/soc/renesas/r8a7779-sysc.c
+++ b/drivers/soc/renesas/r8a7779-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car H1 System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7790-sysc.c b/drivers/soc/renesas/r8a7790-sysc.c
index 7a567ad0ff73..9b5a6bb62152 100644
--- a/drivers/soc/renesas/r8a7790-sysc.c
+++ b/drivers/soc/renesas/r8a7790-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car H2 System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7791-sysc.c b/drivers/soc/renesas/r8a7791-sysc.c
index 03b9f41a34e6..acf545cdebfb 100644
--- a/drivers/soc/renesas/r8a7791-sysc.c
+++ b/drivers/soc/renesas/r8a7791-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car M2-W/N System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7792-sysc.c b/drivers/soc/renesas/r8a7792-sysc.c
index ca7467d7b7ec..05b78525cc43 100644
--- a/drivers/soc/renesas/r8a7792-sysc.c
+++ b/drivers/soc/renesas/r8a7792-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car V2H (R8A7792) System Controller
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7794-sysc.c b/drivers/soc/renesas/r8a7794-sysc.c
index c4da2941e06c..0d42637fa662 100644
--- a/drivers/soc/renesas/r8a7794-sysc.c
+++ b/drivers/soc/renesas/r8a7794-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car E2 System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7795-sysc.c b/drivers/soc/renesas/r8a7795-sysc.c
index 7412666187b3..cda27a67de98 100644
--- a/drivers/soc/renesas/r8a7795-sysc.c
+++ b/drivers/soc/renesas/r8a7795-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car H3 System Controller
  *
  * Copyright (C) 2016-2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7796-sysc.c b/drivers/soc/renesas/r8a7796-sysc.c
index f700c842b9e1..1b06f868b6e8 100644
--- a/drivers/soc/renesas/r8a7796-sysc.c
+++ b/drivers/soc/renesas/r8a7796-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car M3-W System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/soc/renesas/r8a77970-sysc.c
index caf894f193ed..35b30d6a8958 100644
--- a/drivers/soc/renesas/r8a77970-sysc.c
+++ b/drivers/soc/renesas/r8a77970-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car V3M System Controller
  *
  * Copyright (C) 2017 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a77995-sysc.c b/drivers/soc/renesas/r8a77995-sysc.c
index 1b2ef415bbe1..6243aaaf60fb 100644
--- a/drivers/soc/renesas/r8a77995-sysc.c
+++ b/drivers/soc/renesas/r8a77995-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car D3 System Controller
  *
  * Copyright (C) 2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index a447873ce182..0f9f487ca6e2 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * R-Car Gen1 RESET/WDT, R-Car Gen2, Gen3, and RZ/G RST Driver
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/err.h>
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index fe32f7a3b215..93b473debc12 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * R-Car SYSC Power management support
  *
  * Copyright (C) 2014  Magnus Damm
  * Copyright (C) 2015-2017 Glider bvba
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/clk/renesas.h>
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 33defe624a8c..d64037b0b828 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Renesas R-Car System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 #ifndef __SOC_RENESAS_RCAR_SYSC_H__
 #define __SOC_RENESAS_RCAR_SYSC_H__
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index ce19b2732433..9e244206d2dd 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas SoC Identification
  *
  * Copyright (C) 2014-2016 Glider bvba
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
 
 #include <linux/io.h>
-- 
2.11.0
