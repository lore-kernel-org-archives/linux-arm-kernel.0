From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  9 Jan 2018 19:29:54 +0100
Subject: [PATCH 1/3] ARM: EXYNOS: Add SPDX license identifiers
Message-ID: <20180109182956.2456-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL license statements with SPDX GPL-2.0 and GPL-2.0+ license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/include/debug/exynos.S  |  7 ++-----
 arch/arm/include/debug/samsung.S | 10 +++-------
 include/linux/serial_s3c.h       | 17 ++---------------
 3 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/debug/exynos.S b/arch/arm/include/debug/exynos.S
index 60bf3c23200d..74b56769f9cb 100644
--- a/arch/arm/include/debug/exynos.S
+++ b/arch/arm/include/debug/exynos.S
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /* pull in the relevant register and map files. */
 
diff --git a/arch/arm/include/debug/samsung.S b/arch/arm/include/debug/samsung.S
index f4eeed2a1981..69201d7fb48f 100644
--- a/arch/arm/include/debug/samsung.S
+++ b/arch/arm/include/debug/samsung.S
@@ -1,13 +1,9 @@
-/* arch/arm/plat-samsung/include/plat/debug-macro.S
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2005, 2007 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <linux/serial_s3c.h>
 
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index a7f004a3c177..463ed28d2b27 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *  Internal header file for Samsung S3C2410 serial ports (UART0-2)
  *
@@ -10,21 +11,7 @@
  *  Internal header file for MX1ADS serial ports (UART1 & 2)
  *
  *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
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
-*/
+ */
 
 #ifndef __ASM_ARM_REGS_SERIAL_H
 #define __ASM_ARM_REGS_SERIAL_H
-- 
2.11.0
