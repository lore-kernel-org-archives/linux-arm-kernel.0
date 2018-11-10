From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 10 Nov 2018 15:42:54 +0100
Subject: [PATCH 02/17] ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX
 identifier
Message-ID: <1541860974-6676-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Simon Arlott <simon@arlott.org>
Cc: Kapil Hali <kapilh@broadcom.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/mach-bcm/board_bcm2835.c | 11 +----------
 arch/arm/mach-bcm/platsmp.c       | 10 +---------
 arch/arm/mach-bcm/platsmp.h       |  6 +-----
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index 8cff865..bfc556f 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2010 Broadcom
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
  */
 
 #include <linux/init.h>
diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
index 7d95483..47f8053 100644
--- a/arch/arm/mach-bcm/platsmp.c
+++ b/arch/arm/mach-bcm/platsmp.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014-2015 Broadcom Corporation
  * Copyright 2014 Linaro Limited
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/cpumask.h>
diff --git a/arch/arm/mach-bcm/platsmp.h b/arch/arm/mach-bcm/platsmp.h
index b8b8b3f..2af9773 100644
--- a/arch/arm/mach-bcm/platsmp.h
+++ b/arch/arm/mach-bcm/platsmp.h
@@ -1,10 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2017 Stefan Wahren <stefan.wahren@i2se.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
  */
 
 extern const struct smp_operations bcm2836_smp_ops;
-- 
2.7.4
