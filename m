From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Mar 2015 10:06:30 +0200
Subject: [RESEND 6/7] ARM: davinci: irqs: Correct McASP1 TX interrupt
 definition for DM646x
In-Reply-To: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1426147591-31764-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McASP1 TX interrupt is 30, not 32 on DM646x DMSoC

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/include/mach/irqs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index 354af71798dc..edb2ca62321a 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -129,8 +129,8 @@
 #define IRQ_DM646X_EMACMISCINT  27
 #define IRQ_DM646X_MCASP0TXINT  28
 #define IRQ_DM646X_MCASP0RXINT  29
+#define IRQ_DM646X_MCASP1TXINT  30
 #define IRQ_DM646X_RESERVED_3   31
-#define IRQ_DM646X_MCASP1TXINT  32
 #define IRQ_DM646X_VLQINT       38
 #define IRQ_DM646X_UARTINT2     42
 #define IRQ_DM646X_SPINT0       43
-- 
2.3.0
