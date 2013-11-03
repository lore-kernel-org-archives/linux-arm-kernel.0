From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sun,  3 Nov 2013 08:25:29 +0100
Subject: [PATCH] ARM: S3C24XX: remove unused Kconfig parameter
Message-ID: <1383463529-3113-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the MACH_S3C2413 Kconfig parameter,
which was no longer used anywhere in the source code
and Makefiles.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-s3c24xx/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index dba2173e70f3..9d90dd06cf2f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -415,13 +415,6 @@ config MACH_JIVE_SHOW_BOOTLOADER
 	bool "Allow access to bootloader partitions in MTD"
 	depends on MACH_JIVE
 
-config MACH_S3C2413
-	bool
-	help
-	  Internal node for S3C2413 version of SMDK2413, so that
-	  machine_is_s3c2413() will work when MACH_SMDK2413 is
-	  selected
-
 config MACH_SMDK2412
 	bool "SMDK2412"
 	select MACH_SMDK2413
-- 
1.8.1.2
