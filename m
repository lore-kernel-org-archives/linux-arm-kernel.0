From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sun, 27 Oct 2013 08:14:58 +0100
Subject: [PATCH] ARM: remove unused XSCALE_PMU Kconfig param
Message-ID: <1382858098-3548-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the XSCALE_PMU Kconfig param, which is defined
but no longer used in makefiles and source files.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..6de847c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1091,11 +1091,6 @@ config IWMMXT
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
 
-config XSCALE_PMU
-	bool
-	depends on CPU_XSCALE
-	default y
-
 config MULTI_IRQ_HANDLER
 	bool
 	help
-- 
1.8.1.2
