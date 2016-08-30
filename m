From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 30 Aug 2016 12:00:46 +0100
Subject: [PATCH 5/8] ARM: sa1100/nanoengine: remove redundant definitions
In-Reply-To: <20160830105950.GA15580@n2100.armlinux.org.uk>
References: <20160830105950.GA15580@n2100.armlinux.org.uk>
Message-ID: <E1begmc-0007IM-6q@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove redundant GPIO definitions from mach/nanoengine.h

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/nanoengine.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/nanoengine.h b/arch/arm/mach-sa1100/include/mach/nanoengine.h
index 5ebd469a31f2..29ec4bfe5009 100644
--- a/arch/arm/mach-sa1100/include/mach/nanoengine.h
+++ b/arch/arm/mach-sa1100/include/mach/nanoengine.h
@@ -16,18 +16,7 @@
 
 #include <mach/irqs.h>
 
-#define GPIO_PC_READY0	11 /* ready for socket 0 (active high)*/
-#define GPIO_PC_READY1	12 /* ready for socket 1 (active high) */
-#define GPIO_PC_CD0	13 /* detect for socket 0 (active low) */
-#define GPIO_PC_CD1	14 /* detect for socket 1 (active low) */
-#define GPIO_PC_RESET0	15 /* reset socket 0 */
-#define GPIO_PC_RESET1	16 /* reset socket 1 */
-
 #define NANOENGINE_IRQ_GPIO_PCI		IRQ_GPIO0
-#define NANOENGINE_IRQ_GPIO_PC_READY0	IRQ_GPIO11
-#define NANOENGINE_IRQ_GPIO_PC_READY1	IRQ_GPIO12
-#define NANOENGINE_IRQ_GPIO_PC_CD0	IRQ_GPIO13
-#define NANOENGINE_IRQ_GPIO_PC_CD1	IRQ_GPIO14
 
 /*
  * nanoEngine Memory Map:
-- 
2.1.0
