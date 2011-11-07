From: khilman@ti.com (Kevin Hilman)
Date: Mon,  7 Nov 2011 15:58:40 -0800
Subject: [PATCH] ARM: OMAP3: CPUidle: include <linux/export.h>
Message-ID: <1320710320-8279-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPUidle use THIS_MODULE, so needs <linux/export.h>

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, one more for omap/fixes.   This one applies to Linus' master branch,
but also applies to your current omap/fixes.

 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4bf6e6e..2e0fa5a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/export.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-- 
1.7.6
