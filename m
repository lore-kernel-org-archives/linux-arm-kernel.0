From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 19 Mar 2013 22:27:29 +0100
Subject: [PATCH] ARM: remove unused "config XSCALE_PMU"
Message-ID: <1363728449.1390.38.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reference to Kconfig symbol XSCALE_PMU got removed in v3.7,
with commit f0d1bc47953743aef9d2ed5326bc5973a3db08ab ("ARM: pmu: remove
unused reservation mechanism"). We can remove the Kconfig entry for
this unused symbol now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c3bdce..0ff7081 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1189,11 +1189,6 @@ config IWMMXT
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
1.7.11.7
