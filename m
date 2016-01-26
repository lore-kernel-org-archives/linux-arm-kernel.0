From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 26 Jan 2016 18:09:21 +0900
Subject: [PATCH] i2c: uniphier: fix typos in error messages
Message-ID: <1453799361-21910-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 2 +-
 drivers/i2c/busses/i2c-uniphier.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index f3e5ff8..213ba55 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -467,7 +467,7 @@ static int uniphier_fi2c_clk_init(struct device *dev,
 		bus_speed = UNIPHIER_FI2C_DEFAULT_SPEED;
 
 	if (!bus_speed) {
-		dev_err(dev, "clock-freqyency should not be zero\n");
+		dev_err(dev, "clock-frequency should not be zero\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 1f4f3f5..89eaa8a 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -328,7 +328,7 @@ static int uniphier_i2c_clk_init(struct device *dev,
 		bus_speed = UNIPHIER_I2C_DEFAULT_SPEED;
 
 	if (!bus_speed) {
-		dev_err(dev, "clock-freqyency should not be zero\n");
+		dev_err(dev, "clock-frequency should not be zero\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
