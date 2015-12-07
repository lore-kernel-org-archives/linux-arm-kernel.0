From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:21 +0000
Subject: [PATCH 08/19] mfd: adp5520: Some trivial 'no space before tab' fixes
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: please, no space before tabs
+ * ^IMike Rapoport <mike@compulab.co.il>$

WARNING: please, no space before tabs
+ * ^IEric Miao <eric.miao@marvell.com>$

WARNING: please, no space before tabs
+^I.id_table ^I= adp5520_id,$

total: 0 errors, 3 warnings, 365 lines checked

Cc: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/adp5520.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index ae88654..d817f20 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -9,10 +9,10 @@
  *
  * Derived from da903x:
  * Copyright (C) 2008 Compulab, Ltd.
- * 	Mike Rapoport <mike@compulab.co.il>
+ *	Mike Rapoport <mike@compulab.co.il>
  *
  * Copyright (C) 2006-2008 Marvell International Ltd.
- * 	Eric Miao <eric.miao@marvell.com>
+ *	Eric Miao <eric.miao@marvell.com>
  *
  * Licensed under the GPL-2 or later.
  */
@@ -355,7 +355,7 @@ static struct i2c_driver adp5520_driver = {
 	},
 	.probe		= adp5520_probe,
 	.remove		= adp5520_remove,
-	.id_table 	= adp5520_id,
+	.id_table	= adp5520_id,
 };
 
 module_i2c_driver(adp5520_driver);
-- 
1.9.1
