From: pkocieln@mion.elka.pw.edu.pl (Patryk Kocielnik)
Date: Fri, 26 Jan 2018 21:19:26 +0100
Subject: [PATCH] i2c: busses: i2c-sirf: Fix spelling: "formular" -> "formula".
Message-ID: <20180126201926.18804-1-patryk@kocielnik.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix spelling.

Signed-off-by: Patryk Kocielnik <patryk.kocielnik@gmail.com>
---
 drivers/i2c/busses/i2c-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 2fd8b6d00..605c8217f 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -369,7 +369,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 	 * but they start to affect the speed when clock is set to faster
 	 * frequencies.
 	 * Through the actual tests, use the different user_div value(which
-	 * in the divider formular 'Fio / (Fi2c * user_div)') to adapt
+	 * in the divider formula 'Fio / (Fi2c * user_div)') to adapt
 	 * the different ranges of i2c bus clock frequency, to make the SCL
 	 * more accurate.
 	 */
-- 
2.14.3
