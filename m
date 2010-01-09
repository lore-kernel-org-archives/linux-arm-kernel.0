From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Sat, 09 Jan 2010 05:11:45 -0500
Subject: [PATCH] GTA02: Fix build adding NAND and USB host entries to Kconfig
Message-ID: <20100109101145.9632.42319.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add S3C_DEV_USB_HOST and S3C_DEV_NAND to Kconfig to
avoid building errors.

Signed-off-by: Nelson Castillo <arhuaco@freaks-unidos.net>
---

 arch/arm/mach-s3c2442/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2442/Kconfig b/arch/arm/mach-s3c2442/Kconfig
index 8d38118..f68b25f 100644
--- a/arch/arm/mach-s3c2442/Kconfig
+++ b/arch/arm/mach-s3c2442/Kconfig
@@ -31,6 +31,8 @@ config MACH_NEO1973_GTA02
 	select POWER_SUPPLY
 	select MACH_NEO1973
 	select S3C2410_PWM
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
 	help
 	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
 
