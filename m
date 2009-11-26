From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Fri, 27 Nov 2009 05:26:16 +0530
Subject: [PATCH v4 5/6] ARM nomadik: enable U8500 for common platform
Message-ID: <1259279776.13327.74.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Fri, 27 Nov 2009 15:46:48 +0530

Enable U8500 architecture to get access to
the common code shared across various
ST-Ericsson's machines like nomadik.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 arch/arm/plat-nomadik/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index e27ee31..159daf5 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -4,7 +4,7 @@
 
 config PLAT_NOMADIK
 	bool
-	depends on ARCH_NOMADIK
+	depends on ARCH_NOMADIK || ARCH_U8500
 	default y
 	help
 	  Common platform code for Nomadik and other ST-Ericsson
-- 
1.6.3.GIT
