From: john.ogness@linutronix.de (John Ogness)
Date: Tue, 10 Aug 2010 13:35:22 +0200
Subject: [PATCH 2/3] mxc_nand: remove unused variables
In-Reply-To: <80r5i63dn4.fsf@merkur.tec.linutronix.de> (John Ogness's message
	of "Tue, 10 Aug 2010 13:34:07 +0200")
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
Message-ID: <80mxsu3dl1.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes some unused variable declarations.

This patch is against the latest patches from Sascha Hauer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-2.6-454a740.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
@@ -1221,8 +1221,6 @@ static int mxcnd_suspend(struct platform
 static int mxcnd_resume(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct nand_chip *nand_chip = mtd->priv;
-	struct mxc_nand_host *host = nand_chip->priv;
 	int ret = 0;
 
 	DEBUG(MTD_DEBUG_LEVEL0, "MXC_ND : NAND resume\n");
