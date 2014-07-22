From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:19 +0100
Subject: [PATCH 13/19] mfd: wm8350-i2c: Replace spaces with tabs
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: please, no spaces at the start of a line
+       { "wm8350", 0 },$

WARNING: please, no spaces at the start of a line
+       { "wm8351", 0 },$

WARNING: please, no spaces at the start of a line
+       { "wm8352", 0 },$

WARNING: please, no spaces at the start of a line
+       { }$

total: 0 errors, 4 warnings, 93 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm8350-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/wm8350-i2c.c b/drivers/mfd/wm8350-i2c.c
index f919def..6a16a8a 100644
--- a/drivers/mfd/wm8350-i2c.c
+++ b/drivers/mfd/wm8350-i2c.c
@@ -58,10 +58,10 @@ static int wm8350_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8350_i2c_id[] = {
-       { "wm8350", 0 },
-       { "wm8351", 0 },
-       { "wm8352", 0 },
-       { }
+	{ "wm8350", 0 },
+	{ "wm8351", 0 },
+	{ "wm8352", 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8350_i2c_id);
 
-- 
1.8.3.2
