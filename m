From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 01 Jan 2010 18:03:47 +0800
Subject: [PATCH] ARM: NUC900: rename mtd nand driver name
Message-ID: <4B3DC883.5060405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear David,

Due to I have renamed the platform_device.name,so this patch changes
this nand driver platform_driver name.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 drivers/mtd/nand/w90p910_nand.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/w90p910_nand.c
b/drivers/mtd/nand/w90p910_nand.c
index 7680e73..c2e9b68 100644
--- a/drivers/mtd/nand/w90p910_nand.c
+++ b/drivers/mtd/nand/w90p910_nand.c
@@ -358,7 +358,7 @@ static struct platform_driver w90p910_nand_driver = {
 	.probe		= w90p910_nand_probe,
 	.remove		= __devexit_p(w90p910_nand_remove),
 	.driver		= {
-		.name	= "w90p910-fmi",
+		.name	= "nuc900-fmi",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -379,4 +379,4 @@ module_exit(w90p910_nand_exit);
 MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
 MODULE_DESCRIPTION("w90p910 nand driver!");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:w90p910-fmi");
+MODULE_ALIAS("platform:nuc900-fmi");
-- 
1.5.6.3
