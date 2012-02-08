From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 08 Feb 2012 16:37:08 +0000
Subject: [PATCH 04/16] ARM: omap: fix prm44xx.c OMAP44XX_IRQ_PRCM build error
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Message-ID: <E1RvAW4-0006Gy-S6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/prm44xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 33dd655..a1d6154 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -19,6 +19,7 @@
 
 #include "common.h"
 #include <plat/cpu.h>
+#include <plat/irqs.h>
 #include <plat/prcm.h>
 
 #include "vp.h"
-- 
1.7.4.4
