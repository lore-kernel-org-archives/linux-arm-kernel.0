From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  7 Dec 2015 11:50:26 +0000
Subject: [PATCH 13/19] mfd: cros_ec_i2c: Fix trivial 'tabs before spaces'
 whitespace issue.
In-Reply-To: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
References: <1449489032-14374-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449489032-14374-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ERROR: code indent should use tabs where possible
+ ^Iec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);$

WARNING: please, no space before tabs
+ ^Iec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);$

WARNING: please, no spaces at the start of a line
+ ^Iec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);$

total: 1 errors, 2 warnings, 366 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cros_ec_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
index d06e4b4..43db7bd 100644
--- a/drivers/mfd/cros_ec_i2c.c
+++ b/drivers/mfd/cros_ec_i2c.c
@@ -292,7 +292,7 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
 	struct cros_ec_device *ec_dev = NULL;
 	int err;
 
- 	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
+	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
 	if (!ec_dev)
 		return -ENOMEM;
 
-- 
1.9.1
