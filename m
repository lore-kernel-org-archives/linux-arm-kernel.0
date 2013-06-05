From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:19 +0900
Subject: [PATCH 088/130] ARM: shmobile: r8a7740: Remove INTC function GPIOs
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-89-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h | 34 ---------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index bb207d8..dea430e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -100,40 +100,6 @@ enum {
 
 	GPIO_PORT210, GPIO_PORT211,
 
-	/* IRQ */
-	GPIO_FN_IRQ0_PORT2,	GPIO_FN_IRQ0_PORT13,
-	GPIO_FN_IRQ1,
-	GPIO_FN_IRQ2_PORT11,	GPIO_FN_IRQ2_PORT12,
-	GPIO_FN_IRQ3_PORT10,	GPIO_FN_IRQ3_PORT14,
-	GPIO_FN_IRQ4_PORT15,	GPIO_FN_IRQ4_PORT172,
-	GPIO_FN_IRQ5_PORT0,	GPIO_FN_IRQ5_PORT1,
-	GPIO_FN_IRQ6_PORT121,	GPIO_FN_IRQ6_PORT173,
-	GPIO_FN_IRQ7_PORT120,	GPIO_FN_IRQ7_PORT209,
-	GPIO_FN_IRQ8,
-	GPIO_FN_IRQ9_PORT118,	GPIO_FN_IRQ9_PORT210,
-	GPIO_FN_IRQ10,
-	GPIO_FN_IRQ11,
-	GPIO_FN_IRQ12_PORT42,	GPIO_FN_IRQ12_PORT97,
-	GPIO_FN_IRQ13_PORT64,	GPIO_FN_IRQ13_PORT98,
-	GPIO_FN_IRQ14_PORT63,	GPIO_FN_IRQ14_PORT99,
-	GPIO_FN_IRQ15_PORT62,	GPIO_FN_IRQ15_PORT100,
-	GPIO_FN_IRQ16_PORT68,	GPIO_FN_IRQ16_PORT211,
-	GPIO_FN_IRQ17,
-	GPIO_FN_IRQ18,
-	GPIO_FN_IRQ19,
-	GPIO_FN_IRQ20,
-	GPIO_FN_IRQ21,
-	GPIO_FN_IRQ22,
-	GPIO_FN_IRQ23,
-	GPIO_FN_IRQ24,
-	GPIO_FN_IRQ25,
-	GPIO_FN_IRQ26_PORT58,	GPIO_FN_IRQ26_PORT81,
-	GPIO_FN_IRQ27_PORT57,	GPIO_FN_IRQ27_PORT168,
-	GPIO_FN_IRQ28_PORT56,	GPIO_FN_IRQ28_PORT169,
-	GPIO_FN_IRQ29_PORT50,	GPIO_FN_IRQ29_PORT170,
-	GPIO_FN_IRQ30_PORT49,	GPIO_FN_IRQ30_PORT171,
-	GPIO_FN_IRQ31_PORT41,	GPIO_FN_IRQ31_PORT167,
-
 	/* Function */
 
 	/* DBGT */
-- 
1.8.2.1
