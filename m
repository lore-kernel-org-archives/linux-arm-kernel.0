From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:13 -0500
Subject: [PATCH 25/35] arm: omap: irq: remove unnecessary header
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-26-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need for that header to be included.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 14716a8..a405b96 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -24,7 +24,6 @@
 #include <linux/of_irq.h>
 
 #include "soc.h"
-#include "iomap.h"
 #include "common.h"
 #include "../../drivers/irqchip/irqchip.h"
 
-- 
2.0.1.563.g66f467c
