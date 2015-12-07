From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:23 +0000
Subject: [PATCH 10/19] mfd: arizona-i2c: Add blank line formatting after
 declaration
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: Missing a blank line after declarations
+       struct arizona *arizona = dev_get_drvdata(&i2c->dev);
+       arizona_dev_exit(arizona);

total: 0 errors, 1 warnings, 120 lines checked

Cc: patches at opensource.wolfsonmicro.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/arizona-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index cea1b40..68c3e99 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -87,7 +87,9 @@ static int arizona_i2c_probe(struct i2c_client *i2c,
 static int arizona_i2c_remove(struct i2c_client *i2c)
 {
 	struct arizona *arizona = dev_get_drvdata(&i2c->dev);
+
 	arizona_dev_exit(arizona);
+
 	return 0;
 }
 
-- 
1.9.1
