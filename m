From: s-anna@ti.com (Suman Anna)
Date: Thu, 31 May 2018 12:11:01 -0500
Subject: [PATCH 3/5] rpmsg: smd: Switch to SPDX license identifier
In-Reply-To: <20180531171103.8703-1-s-anna@ti.com>
References: <20180531171103.8703-1-s-anna@ti.com>
Message-ID: <20180531171103.8703-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the appropriate SPDX license identifier in the rpmsg SMD backend
driver source file and drop the previous boilerplate license text.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/qcom_smd.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 5ce9bf7b897d..0819836fc178 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, Sony Mobile Communications AB.
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/interrupt.h>
-- 
2.17.0
