From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 8 Nov 2011 17:11:05 +0100
Subject: [PATCH] arm: cpuidle34xx.c: Fix compile error
Message-ID: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing module.h include to provide THIS_MODULE.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1fe35c2..158c17e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <linux/module.h>
 
 #include <plat/prcm.h>
 #include <plat/irqs.h>
-- 
1.7.5.4
