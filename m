From: computersforpeace@gmail.com (Brian Norris)
Date: Fri,  5 Sep 2014 16:25:37 -0700
Subject: [PATCH] ARM: brcmstb: Kconfig: drop unneeded symbol selections
Message-ID: <1409959537-14217-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are either implied or not necessary.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
Based on some of Rob's comments from earlier review

 arch/arm/mach-bcm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index fc938005ad39..fa9e6134fa72 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -101,10 +101,7 @@ config ARCH_BCM_5301X
 
 config ARCH_BRCMSTB
 	bool "Broadcom BCM7XXX based boards" if ARCH_MULTI_V7
-	depends on MMU
 	select ARM_GIC
-	select MIGHT_HAVE_PCI
-	select HAVE_SMP
 	select HAVE_ARM_ARCH_TIMER
 	select BRCMSTB_GISB_ARB
 	select BRCMSTB_L2_IRQ
-- 
1.9.1
