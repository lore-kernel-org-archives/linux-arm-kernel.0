From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Jul 2013 16:56:36 -0500
Subject: [PATCH 5/7] ARM: highbank: clean-up some unused includes
In-Reply-To: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375048598-15637-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index dc5d6be..0f5c661 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -18,14 +18,11 @@
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
-#include <linux/smp.h>
 #include <linux/amba/bus.h>
 #include <linux/clk-provider.h>
 
@@ -35,7 +32,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 
 #include "core.h"
 #include "sysregs.h"
-- 
1.8.1.2
