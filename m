From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 10 Sep 2018 19:05:01 +0200
Subject: [PATCH] ARM: s3c24xx: Consistently use tab for indenting member
 assignments
Message-ID: <20180910170501.14190-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code was mixing spaces and tabs for indenting members in structures.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 4a0bf6abba8c..925ff1b3198e 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -70,25 +70,25 @@ static struct map_desc mini2440_iodesc[] __initdata = {
 
 static struct s3c2410_uartcfg mini2440_uartcfgs[] __initdata = {
 	[0] = {
-		.hwport	     = 0,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= UCON,
+		.ulcon		= ULCON,
+		.ufcon		= UFCON,
 	},
 	[1] = {
-		.hwport	     = 1,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport		= 1,
+		.flag		= 0,
+		.ucon		= UCON,
+		.ulcon		= ULCON,
+		.ufcon		= UFCON,
 	},
 	[2] = {
-		.hwport	     = 2,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= UCON,
+		.ulcon		= ULCON,
+		.ufcon		= UFCON,
 	},
 };
 
@@ -234,10 +234,10 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 /* MMC/SD  */
 
 static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
-	.gpio_detect   = S3C2410_GPG(8),
-	.gpio_wprotect = S3C2410_GPH(8),
-	.set_power     = NULL,
-	.ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
+	.gpio_detect	= S3C2410_GPG(8),
+	.gpio_wprotect	= S3C2410_GPH(8),
+	.set_power	= NULL,
+	.ocr_avail	= MMC_VDD_32_33|MMC_VDD_33_34,
 };
 
 /* NAND Flash on MINI2440 board */
@@ -285,7 +285,7 @@ static struct s3c2410_platform_nand mini2440_nand_info __initdata = {
 	.nr_sets	= ARRAY_SIZE(mini2440_nand_sets),
 	.sets		= mini2440_nand_sets,
 	.ignore_unset_ecc = 1,
-	.ecc_mode       = NAND_ECC_HW,
+	.ecc_mode	= NAND_ECC_HW,
 };
 
 /* DM9000AEP 10/100 ethernet controller */
-- 
2.14.1
