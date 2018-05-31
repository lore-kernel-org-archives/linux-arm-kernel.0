From: s-anna@ti.com (Suman Anna)
Date: Thu, 31 May 2018 12:11:03 -0500
Subject: [PATCH 5/5] rpmsg: char: Switch to SPDX license identifier
In-Reply-To: <20180531171103.8703-1-s-anna@ti.com>
References: <20180531171103.8703-1-s-anna@ti.com>
Message-ID: <20180531171103.8703-6-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the appropriate SPDX license identifier in the rpmsg char driver
source file and drop the previous boilerplate license text. The uapi
header file already had the SPDX license identifier added as part of
a mass update but the license text removal was deferred for later,
and this patch drops the same.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/rpmsg_char.c | 10 +---------
 include/uapi/linux/rpmsg.h |  9 ---------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 1efdf9ff8679..76a4477c6364 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016, Linaro Ltd.
  * Copyright (c) 2012, Michal Simek <monstr@monstr.eu>
@@ -7,15 +8,6 @@
  *
  * Based on rpmsg performance statistics driver by Michal Simek, which in turn
  * was based on TI & Google OMX rpmsg driver.
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
 #include <linux/cdev.h>
 #include <linux/device.h>
diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
index 225eb38705dc..e14c6dab4223 100644
--- a/include/uapi/linux/rpmsg.h
+++ b/include/uapi/linux/rpmsg.h
@@ -1,15 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Copyright (c) 2016, Linaro Ltd.
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
 
 #ifndef _UAPI_RPMSG_H_
-- 
2.17.0
