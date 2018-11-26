From: pn@denx.de (Parthiban Nallathambi)
Date: Mon, 26 Nov 2018 19:58:19 +0100
Subject: [PATCH v2 2/4] i2c: Add Actions Semiconductor Owl family S700 I2C
 support
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Message-ID: <20181126185821.2480449-3-pn@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add S700 to the list of devices supported by Owl I2C driver.

Add Actions Semiconductor Owl family S900 I2C driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 drivers/i2c/busses/i2c-owl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 96b4572e6d9c..b6b5a495118b 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id owl_i2c_of_match[] = {
+	{ .compatible = "actions,s700-i2c" },
 	{ .compatible = "actions,s900-i2c" },
 	{ /* sentinel */ }
 };
-- 
2.17.2
