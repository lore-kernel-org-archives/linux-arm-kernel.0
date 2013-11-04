From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  4 Nov 2013 10:28:03 +0100
Subject: [PATCH] ARM: remove unused XSCALE_PMU Kconfig parameter
Message-ID: <1383557283-4666-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the XSCALE_PMU Kconfig parameter,
which was no longer used anywhere in the source code
and Makefiles.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6c094d..6de847c74759 100644
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
