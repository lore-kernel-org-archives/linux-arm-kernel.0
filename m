From: rjui@broadcom.com (Ray Jui)
Date: Thu, 28 May 2015 18:09:14 -0700
Subject: [PATCH] ARM: BCM: Enable NAND support for iProc SoCs
Message-ID: <1432861754-26606-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_MTD_NAND_BRCMNAND for all iProc SoCs

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8b11f44..1268e35 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
+	select MTD_NAND_BRCMNAND
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
-- 
1.7.9.5
