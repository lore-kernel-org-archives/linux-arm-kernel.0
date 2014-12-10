From: rjui@broadcom.com (Ray Jui)
Date: Tue, 9 Dec 2014 16:04:30 -0800
Subject: [PATCH 3/4] ARM: mach-bcm: Enable PCIe support for iProc
In-Reply-To: <1418169871-19232-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418169871-19232-1-git-send-email-rjui@broadcom.com>
Message-ID: <1418169871-19232-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PCIe driver support for Broadcom iProc family of SoCs by
selecting PCIE_IPROC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index aaeec78..a13a0b2 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
+	select PCIE_IPROC
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
-- 
1.7.9.5
