From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jul 2012 08:18:18 -0300
Subject: [PATCH v2 1/3] mtd: nand: Include IMX6 in the list of supported SoCs
Message-ID: <1343215100-24005-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Include IMX6 in the list of supported SoCs.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- No changes
 drivers/mtd/nand/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index f4e81a7..b40e172 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -464,7 +464,7 @@ config MTD_NAND_GPMI_NAND
         bool "GPMI NAND Flash Controller driver"
         depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
         help
-	 Enables NAND Flash support for IMX23 or IMX28.
+	 Enables NAND Flash support for IMX23, IMX28 or IMX6.
 	 The GPMI controller is very powerful, with the help of BCH
 	 module, it can do the hardware ECC. The GPMI supports several
 	 NAND flashs at the same time. The GPMI may conflicts with other
-- 
1.7.1
