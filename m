From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Sep 2015 12:35:13 +0200
Subject: [PATCH 1/3] power: reset: at91-reset/trivial: driver applies to SAMA5
 family as well
Message-ID: <bc6fb78ccf190a6e24f69d70036bc3cd3ec42673.1441881064.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This diver doesn't applies only on SAM9 SoC families but on SAMA5 families
as well.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/power/reset/at91-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index c378d4ec826f..264b9b81b9f7 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -1,5 +1,5 @@
 /*
- * Atmel AT91 SAM9 SoCs reset code
+ * Atmel AT91 SAM9 & SAMA5 SoCs reset code
  *
  * Copyright (C) 2007 Atmel Corporation.
  * Copyright (C) BitBox Ltd 2010
-- 
2.1.3
