From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:58:04 +0000
Subject: [PATCH] ARM: S3C24XX: Remove old mach-s3c2442
In-Reply-To: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
References: <1264492686-16901-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264492686-16901-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the old mach-s3c2442 directory now all is merged into mach-s3c2440
and remove it from the arch/arm build process.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig               |    1 -
 arch/arm/Makefile              |    2 +-
 arch/arm/mach-s3c2442/Kconfig  |    4 ----
 arch/arm/mach-s3c2442/Makefile |   15 ---------------
 4 files changed, 1 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2442/Kconfig
 delete mode 100644 arch/arm/mach-s3c2442/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3bc5169..63f726f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -794,7 +794,6 @@ source "arch/arm/mach-s3c2400/Kconfig"
 source "arch/arm/mach-s3c2410/Kconfig"
 source "arch/arm/mach-s3c2412/Kconfig"
 source "arch/arm/mach-s3c2440/Kconfig"
-source "arch/arm/mach-s3c2442/Kconfig"
 source "arch/arm/mach-s3c2443/Kconfig"
 endif
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index bbcd512..893bcfc 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -158,7 +158,7 @@ machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
 machine-$(CONFIG_ARCH_PXA)		:= pxa
 machine-$(CONFIG_ARCH_REALVIEW)		:= realview
 machine-$(CONFIG_ARCH_RPC)		:= rpc
-machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c2443
+machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2443
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
 machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
diff --git a/arch/arm/mach-s3c2442/Kconfig b/arch/arm/mach-s3c2442/Kconfig
deleted file mode 100644
index 29ef066..0000000
--- a/arch/arm/mach-s3c2442/Kconfig
+++ /dev/null
@@ -1,4 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
diff --git a/arch/arm/mach-s3c2442/Makefile b/arch/arm/mach-s3c2442/Makefile
deleted file mode 100644
index 7e31ccd..0000000
--- a/arch/arm/mach-s3c2442/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-# arch/arm/mach-s3c2442/Makefile
-#
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
-
-# Machine support
-
-- 
1.6.0.4
