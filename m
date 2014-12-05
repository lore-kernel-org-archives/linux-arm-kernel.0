From: rjui@broadcom.com (Ray Jui)
Date: Fri, 5 Dec 2014 11:51:08 -0800
Subject: [PATCH v2 3/4] ARM: mach-bcm: enable pinctrl support for Cygnus
In-Reply-To: <1417809069-26510-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1417809069-26510-1-git-send-email-rjui@broadcom.com>
Message-ID: <1417809069-26510-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the pinctrl driver for Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index aaeec78..b4efff2 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -29,6 +29,7 @@ config ARCH_BCM_IPROC
 config ARCH_BCM_CYGNUS
 	bool "Broadcom Cygnus Support" if ARCH_MULTI_V7
 	select ARCH_BCM_IPROC
+	select PINCTRL_BCM_CYGNUS
 	help
 	  Enable support for the Cygnus family,
 	  which includes the following variants:
-- 
1.7.9.5
