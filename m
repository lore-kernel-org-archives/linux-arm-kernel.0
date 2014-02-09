From: richard@nod.at (Richard Weinberger)
Date: Sun,  9 Feb 2014 19:48:00 +0100
Subject: [PATCH 22/28] Remove S3C24XX_GPIO_EXTRA128
In-Reply-To: <1391971686-9517-1-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
Message-ID: <1391971686-9517-23-git-send-email-richard@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/mach-s3c24xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 1c67f04..bb1fa603 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -561,7 +561,6 @@ config MACH_OSIRIS
 	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 	select S3C2440_XTAL_12000000
 	select S3C24XX_DCLK
-	select S3C24XX_GPIO_EXTRA128
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
-- 
1.8.4.2
