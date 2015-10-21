From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 21 Oct 2015 10:29:01 +0200
Subject: [PATCH v4 2/5] mtd: nand: allow compile test of MTD_NAND_PXA3xx
In-Reply-To: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1445416144-9194-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow compile test of the MTD_NAND_PXA3xx nand driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 289664089cf3..554aff7b2f8b 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -329,7 +329,7 @@ config MTD_NAND_ATMEL
 
 config MTD_NAND_PXA3xx
 	tristate "NAND support on PXA3xx and Armada 370/XP"
-	depends on PXA3xx || ARCH_MMP || PLAT_ORION
+	depends on PXA3xx || ARCH_MMP || PLAT_ORION || COMPILE_TEST
 	help
 	  This enables the driver for the NAND flash device found on
 	  PXA3xx processors (NFCv1) and also on Armada 370/XP (NFCv2).
-- 
2.6.2
