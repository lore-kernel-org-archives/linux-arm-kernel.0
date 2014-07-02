From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:41 +0100
Subject: [PATCH 09/12] mfd: 88pm860x-i2c: Repair 'space before tab' warning
In-Reply-To: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404314924-23564-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes checkpatch warning:

    WARNING: please, no space before tabs
    #5: FILE: drivers/mfd/88pm860x-i2c.c:5:
    + * ^IHaojian Zhuang <haojian.zhuang@marvell.com>$

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/88pm860x-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index ff8f803..a93b4d0 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -2,7 +2,8 @@
  * I2C driver for Marvell 88PM860x
  *
  * Copyright (C) 2009 Marvell International Ltd.
- * 	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@marvell.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.8.3.2
