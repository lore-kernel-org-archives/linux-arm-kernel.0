From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Wed, 18 Sep 2013 05:23:42 +0200
Subject: [PATCH] ARM: STi: remove unused Kconfig parameters
Message-ID: <1379474622-4715-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the 'SOC_STIH415' and 'SOC_STIH416'
parameters, which are used nowhere else in the source code
and Makefiles.

Will they be needed in code that hasn't been submitted yet?

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-sti/Kconfig | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 835833e..bef1a9f 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -21,26 +21,3 @@ menuconfig ARCH_STI
 	  for discovery
 	  More information at Documentation/arm/STiH41x and
 	  at Documentation/devicetree
-
-
-if ARCH_STI
-
-config SOC_STIH415
-	bool "STiH415 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH415 parts, primarily targetted at set-top-box
-	  and other digital audio/video applications using Flattned Device
-	  Trees.
-
-config SOC_STIH416
-	bool "STiH416 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH416 parts, primarily targetted at set-top-box
-	  and other digital audio/video applications using Flattened Device
-	  Trees.
-
-endif
-- 
1.8.1.2
