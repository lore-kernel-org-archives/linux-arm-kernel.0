From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 02:14:16 +0100
Subject: [PATCH] ARM: SAMSUNG: Remove old email address for ben-linux@fluff.org
Message-ID: <1273626856-9775-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address ben at fluff.org is old, ben-linux at fluff.org has been in use
for a long time, and we should fixup all the occasions of the older
address to avoid confusion.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/mach-h1940.c    |    2 +-
 arch/arm/mach-s3c2412/mach-jive.c     |    2 +-
 arch/arm/mach-s3c2412/mach-smdk2413.c |    6 +++---
 arch/arm/mach-s3c2440/mach-rx3715.c   |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c |    2 +-
 arch/arm/mach-s3c2443/mach-smdk2443.c |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 9531b4c..8a26fe1 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -339,7 +339,7 @@ static void __init h1940_init(void)
 }
 
 MACHINE_START(H1940, "IPAQ-H1940")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 4316018..478f4b4 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -674,7 +674,7 @@ static void __init jive_machine_init(void)
 }
 
 MACHINE_START(JIVE, "JIVE")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
diff --git a/arch/arm/mach-s3c2412/mach-smdk2413.c b/arch/arm/mach-s3c2412/mach-smdk2413.c
index faddb36..ba93a35 100644
--- a/arch/arm/mach-s3c2412/mach-smdk2413.c
+++ b/arch/arm/mach-s3c2412/mach-smdk2413.c
@@ -150,7 +150,7 @@ static void __init smdk2413_machine_init(void)
 }
 
 MACHINE_START(S3C2413, "S3C2413")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
@@ -163,7 +163,7 @@ MACHINE_START(S3C2413, "S3C2413")
 MACHINE_END
 
 MACHINE_START(SMDK2412, "SMDK2412")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
@@ -176,7 +176,7 @@ MACHINE_START(SMDK2412, "SMDK2412")
 MACHINE_END
 
 MACHINE_START(SMDK2413, "SMDK2413")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 1e836e5..d2946de 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -209,7 +209,7 @@ static void __init rx3715_init_machine(void)
 }
 
 MACHINE_START(RX3715, "IPAQ-RX3715")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c2440/mach-smdk2440.c
index 3ac3d63..df83276 100644
--- a/arch/arm/mach-s3c2440/mach-smdk2440.c
+++ b/arch/arm/mach-s3c2440/mach-smdk2440.c
@@ -174,7 +174,7 @@ static void __init smdk2440_machine_init(void)
 }
 
 MACHINE_START(S3C2440, "SMDK2440")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
diff --git a/arch/arm/mach-s3c2443/mach-smdk2443.c b/arch/arm/mach-s3c2443/mach-smdk2443.c
index e2e362b..4c863d3 100644
--- a/arch/arm/mach-s3c2443/mach-smdk2443.c
+++ b/arch/arm/mach-s3c2443/mach-smdk2443.c
@@ -131,7 +131,7 @@ static void __init smdk2443_machine_init(void)
 }
 
 MACHINE_START(SMDK2443, "SMDK2443")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C2410_PA_UART,
 	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index f7b1898..5991667 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -84,7 +84,7 @@ static void __init smdk6400_machine_init(void)
 }
 
 MACHINE_START(SMDK6400, "SMDK6400")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C_PA_UART & 0xfff00000,
 	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 2d5afd2..9d51455 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -656,7 +656,7 @@ static void __init smdk6410_machine_init(void)
 }
 
 MACHINE_START(SMDK6410, "SMDK6410")
-	/* Maintainer: Ben Dooks <ben@fluff.org> */
+	/* Maintainer: Ben Dooks <ben-linux@fluff.org> */
 	.phys_io	= S3C_PA_UART & 0xfff00000,
 	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
 	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
-- 
1.6.3.3
