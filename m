From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 14 Jan 2010 11:24:13 +0200
Subject: [PATCH 1/3] mtd: mxc_nand: add MX25 to Kconfig
In-Reply-To: <cover.1263460321.git.baruch@tkos.co.il>
References: <cover.1263460321.git.baruch@tkos.co.il>
Message-ID: <7f6094e5c907194486d288691db041455dd77eac.1263460321.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/mtd/nand/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 677cd53..4f99274 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -444,7 +444,7 @@ config MTD_NAND_FSL_UPM
 
 config MTD_NAND_MXC
 	tristate "MXC NAND support"
-	depends on ARCH_MX2 || ARCH_MX3
+	depends on ARCH_MX2 || ARCH_MX25 || ARCH_MX3
 	help
 	  This enables the driver for the NAND flash controller on the
 	  MXC processors.
-- 
1.6.5
