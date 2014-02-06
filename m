From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  7 Feb 2014 00:42:16 +0100
Subject: [PATCH 20/21] ARM: MVEBU: Remove unneeded headers
In-Reply-To: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
Message-ID: <1391730137-14814-21-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove headers which are no longer needed, and add a couple of missing
onces.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mvebu/kirkwood.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 1df0c0b138d5..5d7fef04c36d 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -13,18 +13,15 @@
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mbus.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
-#include <linux/dma-mapping.h>
-#include <linux/irqchip.h>
-#include <linux/kexec.h>
+#include <linux/slab.h>
 #include <asm/hardware/cache-feroceon-l2.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <plat/common.h>
-#include <plat/pcie.h>
 #include "kirkwood.h"
 #include "kirkwood-pm.h"
 #include "common.h"
-- 
1.8.5.3
