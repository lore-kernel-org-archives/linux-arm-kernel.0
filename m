From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 18 Jan 2011 12:21:42 -0500
Subject: [PATCH v1 1/5] davinci: da850: remove unused pinmux array
In-Reply-To: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
References: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1295371306-24035-2-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850_cpgmac_pins pinmux array is not used.  Remove it.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/da850.c              |   11 -----------
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 78b5ae2..a39767c 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -577,17 +577,6 @@ const short da850_i2c1_pins[] __initdata = {
 	-1
 };
 
-const short da850_cpgmac_pins[] __initdata = {
-	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
-	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
-	DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
-	DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
-	DA850_MDIO_D, DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
-	DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1, DA850_RMII_RXER,
-	DA850_RMII_MHZ_50_CLK,
-	-1
-};
-
 const short da850_mcasp_pins[] __initdata = {
 	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
 	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index e7f9520..5f634c8 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -128,7 +128,6 @@ extern const short da850_uart1_pins[];
 extern const short da850_uart2_pins[];
 extern const short da850_i2c0_pins[];
 extern const short da850_i2c1_pins[];
-extern const short da850_cpgmac_pins[];
 extern const short da850_mcasp_pins[];
 extern const short da850_lcdcntl_pins[];
 extern const short da850_mmcsd0_pins[];
-- 
1.7.0.4
