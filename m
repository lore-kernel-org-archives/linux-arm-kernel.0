From: kmpark@infradead.org (Kyungmin Park)
Date: Sat, 19 Jun 2010 13:22:05 +0900
Subject: [PATCH] Remove unused serial flags
Message-ID: <20100619042205.GA24864@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Remove unused serial flags. Only s5p series.
After remove s3c series then remove s3c240_uartcfg flags field.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..1698d03 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -60,28 +60,24 @@
 static struct s3c2410_uartcfg smdkc100_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport	     = 1,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport	     = 2,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport	     = 3,
-		.flags	     = 0,
 		.ucon	     = S5PC100_UCON_DEFAULT,
 		.ulcon	     = S5PC100_ULCON_DEFAULT,
 		.ufcon	     = S5PC100_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 10bc76e..37a62dd 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -46,28 +46,24 @@
 static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 4863b13..b0e54ea 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -43,28 +43,24 @@
 static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 4c8903c..1410a5f 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -43,28 +43,24 @@
 static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 0d46279..e0d72fc 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -45,28 +45,24 @@
 static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
-		.flags		= 0,
 		.ucon		= S5PV210_UCON_DEFAULT,
 		.ulcon		= S5PV210_ULCON_DEFAULT,
 		.ufcon		= S5PV210_UFCON_DEFAULT,
