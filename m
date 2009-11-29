From: njun@marvell.com (Jun Nie)
Date: Sun, 29 Nov 2009 09:41:54 +0800
Subject: [PATCH] gpio: pca953x: add support for MAX7312
Message-ID: <mailman.55.1259461343.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jun Nie <njun@marvell.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 drivers/gpio/pca953x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 6a2fb3f..cfff189 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "pca9557", 8, },

 	{ "max7310", 8, },
+	{ "max7312", 16 },
 	{ "max7315", 8, },
 	{ "pca6107", 8, },
 	{ "tca6408", 8, },
-- 
1.6.3.3
