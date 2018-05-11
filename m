From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 May 2018 12:03:16 -0500
Subject: [PATCH 1/6] hwspinlock/core: Switch to SPDX license identifier
In-Reply-To: <20180511170321.2452-1-s-anna@ti.com>
References: <20180511170321.2452-1-s-anna@ti.com>
Message-ID: <20180511170321.2452-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the appropriate SPDX license identifier in the Hwspinlock core
driver source files and drop the previous boilerplate license text.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/Kconfig               |  1 +
 drivers/hwspinlock/hwspinlock_core.c     | 10 +---------
 drivers/hwspinlock/hwspinlock_internal.h | 10 +---------
 include/linux/hwspinlock.h               | 10 +---------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index f0f467983960..e895d29500ee 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Generic HWSPINLOCK framework
 #
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 4074441444fe..a41bc79aaa15 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardware spinlock framework
  *
  * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
  *
  * Contact: Ohad Ben-Cohen <ohad@wizery.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #define pr_fmt(fmt)    "%s: " fmt, __func__
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index d26f78b8f214..9eb6bd020dc7 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Hardware spinlocks internal header
  *
  * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
  *
  * Contact: Ohad Ben-Cohen <ohad@wizery.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __HWSPINLOCK_HWSPINLOCK_H
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 859d673d98c8..cd6cd7fbd3c9 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Hardware spinlock public header
  *
  * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com
  *
  * Contact: Ohad Ben-Cohen <ohad@wizery.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __LINUX_HWSPINLOCK_H
-- 
2.17.0
