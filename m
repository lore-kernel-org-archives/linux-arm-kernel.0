From: s-anna@ti.com (Suman Anna)
Date: Fri, 11 May 2018 12:03:20 -0500
Subject: [PATCH 5/6] hwspinlock/u8500: Switch to SPDX license identifier
In-Reply-To: <20180511170321.2452-1-s-anna@ti.com>
References: <20180511170321.2452-1-s-anna@ti.com>
Message-ID: <20180511170321.2452-6-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the appropriate SPDX license identifier in the U8500 HWSEM
driver source file and drop the previous boilerplate license text.

Cc: Mathieu J. Poirier <mathieu.poirier@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/u8500_hsem.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index e93eabbd660f..84a92d424e8d 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * u8500 HWSEM driver
  *
@@ -10,15 +11,6 @@
  *   Simon Que <sque@ti.com>
  *   Hari Kanigeri <h-kanigeri2@ti.com>
  *   Ohad Ben-Cohen <ohad@wizery.com>
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
 
 #include <linux/module.h>
-- 
2.17.0
