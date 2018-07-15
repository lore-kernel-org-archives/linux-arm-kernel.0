From: vilhelm.gray@gmail.com (William Breathitt Gray)
Date: Sun, 15 Jul 2018 16:45:44 -0400
Subject: [PATCH v8 04/11] iio: 104-quad-8: Update license boilerplate
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
Message-ID: <bd80be65f742fdedfafcd708033ffd0d9ddae0f7.1531685025.git.vilhelm.gray@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simplifies the boilerplate license text by making use of a
SPDX license identifier line.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 92be8d0f7735..72b6352e09f0 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO driver for the ACCES 104-QUAD-8
  * Copyright (C) 2016 William Breathitt Gray
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  * This driver supports the ACCES 104-QUAD-8 and ACCES 104-QUAD-4.
  */
 #include <linux/bitops.h>
-- 
2.18.0
