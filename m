From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:09:15 -0600
Subject: [RFT/RFC/PATCH 28/31] arm: omap: irq: remove unnecessary header
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-29-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need for that header to be included.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 397157a..5d4e883 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -24,7 +24,6 @@
 #include <linux/of_irq.h>
 
 #include "soc.h"
-#include "iomap.h"
 #include "common.h"
 #include "../../drivers/irqchip/irqchip.h"
 
-- 
1.8.4.GIT
