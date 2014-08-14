From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 14 Aug 2014 10:51:29 -0500
Subject: [PATCH 1/3] ARM: dts: socfpga: remove extra alias in the ArriaV devkit
In-Reply-To: <1408031491-15609-1-git-send-email-dinguyen@opensource.altera.com>
References: <1408031491-15609-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1408031491-15609-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

commit [2755e187 dts: socfpga: Add DTS entry for adding the stmmac glue
layer for stmmac.] added an extra ethernet alias in the ArriaV devkit
board file. This patch removes it.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria5_socdk.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index d532d17..27d551c 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -37,13 +37,6 @@
 		*/
 		ethernet0 = &gmac1;
 	};
-
-	aliases {
-		/* this allow the ethaddr uboot environmnet variable contents
-		 * to be added to the gmac1 device tree blob.
-		 */
-		ethernet0 = &gmac1;
-	};
 };
 
 &gmac1 {
-- 
2.0.3
