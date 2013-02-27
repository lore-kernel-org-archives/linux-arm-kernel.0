From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Feb 2013 21:42:05 -0600
Subject: [PATCH 1/4] ARM: highbank: clean-up some unused includes
In-Reply-To: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
Message-ID: <1361936528-25998-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index a4f9f50..3a5e62c 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -17,14 +17,11 @@
 #include <linux/clkdev.h>
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
 
@@ -38,7 +35,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 
 #include "core.h"
 #include "sysregs.h"
-- 
1.7.10.4
