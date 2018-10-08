From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  8 Oct 2018 11:18:18 +0200
Subject: [PATCH] PM / AVS: SmartReflex: Fix module licence specification
Message-ID: <20181008091818.1145-1-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header of this file claims "version 2" and not "or later". So adapt
the module licence specification accordingly.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 drivers/power/avs/smartreflex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index d29b6313cafc..9ed30b5d32c2 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -1062,6 +1062,6 @@ static void __exit sr_exit(void)
 module_exit(sr_exit);
 
 MODULE_DESCRIPTION("OMAP Smartreflex Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
-- 
2.19.0
