From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:29 +0000
Subject: [PATCH 16/19] mfd: da903x: Fix white space and split string issues
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we're at it, let's also match the MODULE_LICENSE with the header.

WARNING: please, no space before tabs
+ * ^IMike Rapoport <mike@compulab.co.il>$

WARNING: please, no space before tabs
+ * ^IEric Miao <eric.miao@marvell.com>$

WARNING: quoted string split across lines
+MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>"
+             "Mike Rapoport <mike@compulab.co.il>");

total: 0 errors, 3 warnings, 574 lines checked

Cc: Support Opensource <support.opensource@diasemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/da903x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index ef7fe2a..cf3e7a2 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -2,10 +2,10 @@
  * Base driver for Dialog Semiconductor DA9030/DA9034
  *
  * Copyright (C) 2008 Compulab, Ltd.
- * 	Mike Rapoport <mike@compulab.co.il>
+ *	Mike Rapoport <mike@compulab.co.il>
  *
  * Copyright (C) 2006-2008 Marvell International Ltd.
- * 	Eric Miao <eric.miao@marvell.com>
+ *	Eric Miao <eric.miao@marvell.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -569,6 +569,6 @@ static void __exit da903x_exit(void)
 module_exit(da903x_exit);
 
 MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>"
-	      "Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
+MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
