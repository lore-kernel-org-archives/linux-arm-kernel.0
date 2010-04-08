From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 8 Apr 2010 21:05:31 +0200
Subject: [PATCH] ARM: LPC32XX: pm.c - added needed include for slab.h - resend
Message-ID: <083DF309106F364B939360100EC290F809769CEB1C@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Added slab.h include recently needed for kmalloc/kfree See commit 5a0e3ad6af8660be21ca98a971cd00f331318c05
---
 arch/arm/mach-lpc32xx/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c index d792e2e..a6e2aed 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -66,6 +66,7 @@
 
 #include <linux/suspend.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 
 #include <asm/cacheflush.h>
 
--
1.6.6.1
