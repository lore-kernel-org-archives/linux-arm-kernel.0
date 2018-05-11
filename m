From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 May 2018 12:03:21 -0500
Subject: [PATCH 6/6] hwspinlock: sprd: Switch to SPDX license identifier
In-Reply-To: <20180511170321.2452-1-s-anna@ti.com>
References: <20180511170321.2452-1-s-anna@ti.com>
Message-ID: <20180511170321.2452-7-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the appropriate SPDX license identifiers in the Spreadtrum hardware
spinlock driver source file and drop the previous boilerplate license text.

Cc: Baolin Wang <baolin.wang@spreadtrum.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/sprd_hwspinlock.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index 638e64ac18f5..dc42bf51f3e6 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Spreadtrum hardware spinlock driver
  * Copyright (C) 2017 Spreadtrum  - http://www.spreadtrum.com
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/bitops.h>
-- 
2.17.0
