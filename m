From: rjui@broadcom.com (Ray Jui)
Date: Sun, 7 Dec 2014 18:38:34 -0800
Subject: [PATCH v2 3/5] ARM: mach-bcm: Enable GPIO support for Cygnus
In-Reply-To: <1418006316-324-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418006316-324-1-git-send-email-rjui@broadcom.com>
Message-ID: <1418006316-324-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable GPIO driver for Broadcom Cygnus SoC by selecting GPIO_BCM_CYGNUS

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index aaeec78..5066d5d 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -29,6 +29,7 @@ config ARCH_BCM_IPROC
 config ARCH_BCM_CYGNUS
 	bool "Broadcom Cygnus Support" if ARCH_MULTI_V7
 	select ARCH_BCM_IPROC
+	select GPIO_BCM_CYGNUS
 	help
 	  Enable support for the Cygnus family,
 	  which includes the following variants:
-- 
1.7.9.5
