From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 29 Jul 2010 09:04:08 -0700
Subject: [PATCH 1/7] ARM: LPC32xx: Fix naming convention issues with some
	defines
In-Reply-To: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
References: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280419454-1089-2-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Some platform defines were prefixed with LCP instead of LPC.
This has been corrected.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/include/mach/platform.h |   48 ++++++++++++------------
 arch/arm/mach-lpc32xx/timer.c                 |   46 ++++++++++++------------
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index 14ea8d1..85f9aff 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -591,42 +591,42 @@
 /*
  * Timer/counter register offsets
  */
-#define LCP32XX_TIMER_IR(x)			io_p2v((x) + 0x00)
-#define LCP32XX_TIMER_TCR(x)			io_p2v((x) + 0x04)
-#define LCP32XX_TIMER_TC(x)			io_p2v((x) + 0x08)
-#define LCP32XX_TIMER_PR(x)			io_p2v((x) + 0x0C)
-#define LCP32XX_TIMER_PC(x)			io_p2v((x) + 0x10)
-#define LCP32XX_TIMER_MCR(x)			io_p2v((x) + 0x14)
-#define LCP32XX_TIMER_MR0(x)			io_p2v((x) + 0x18)
-#define LCP32XX_TIMER_MR1(x)			io_p2v((x) + 0x1C)
-#define LCP32XX_TIMER_MR2(x)			io_p2v((x) + 0x20)
-#define LCP32XX_TIMER_MR3(x)			io_p2v((x) + 0x24)
-#define LCP32XX_TIMER_CCR(x)			io_p2v((x) + 0x28)
-#define LCP32XX_TIMER_CR0(x)			io_p2v((x) + 0x2C)
-#define LCP32XX_TIMER_CR1(x)			io_p2v((x) + 0x30)
-#define LCP32XX_TIMER_CR2(x)			io_p2v((x) + 0x34)
-#define LCP32XX_TIMER_CR3(x)			io_p2v((x) + 0x38)
-#define LCP32XX_TIMER_EMR(x)			io_p2v((x) + 0x3C)
-#define LCP32XX_TIMER_CTCR(x)			io_p2v((x) + 0x70)
+#define LPC32XX_TIMER_IR(x)			io_p2v((x) + 0x00)
+#define LPC32XX_TIMER_TCR(x)			io_p2v((x) + 0x04)
+#define LPC32XX_TIMER_TC(x)			io_p2v((x) + 0x08)
+#define LPC32XX_TIMER_PR(x)			io_p2v((x) + 0x0C)
+#define LPC32XX_TIMER_PC(x)			io_p2v((x) + 0x10)
+#define LPC32XX_TIMER_MCR(x)			io_p2v((x) + 0x14)
+#define LPC32XX_TIMER_MR0(x)			io_p2v((x) + 0x18)
+#define LPC32XX_TIMER_MR1(x)			io_p2v((x) + 0x1C)
+#define LPC32XX_TIMER_MR2(x)			io_p2v((x) + 0x20)
+#define LPC32XX_TIMER_MR3(x)			io_p2v((x) + 0x24)
+#define LPC32XX_TIMER_CCR(x)			io_p2v((x) + 0x28)
+#define LPC32XX_TIMER_CR0(x)			io_p2v((x) + 0x2C)
+#define LPC32XX_TIMER_CR1(x)			io_p2v((x) + 0x30)
+#define LPC32XX_TIMER_CR2(x)			io_p2v((x) + 0x34)
+#define LPC32XX_TIMER_CR3(x)			io_p2v((x) + 0x38)
+#define LPC32XX_TIMER_EMR(x)			io_p2v((x) + 0x3C)
+#define LPC32XX_TIMER_CTCR(x)			io_p2v((x) + 0x70)
 
 /*
  * ir register definitions
  */
-#define LCP32XX_TIMER_CNTR_MTCH_BIT(n)		(1 << ((n) & 0x3))
-#define LCP32XX_TIMER_CNTR_CAPT_BIT(n)		(1 << (4 + ((n) & 0x3)))
+#define LPC32XX_TIMER_CNTR_MTCH_BIT(n)		(1 << ((n) & 0x3))
+#define LPC32XX_TIMER_CNTR_CAPT_BIT(n)		(1 << (4 + ((n) & 0x3)))
 
 /*
  * tcr register definitions
  */
-#define LCP32XX_TIMER_CNTR_TCR_EN		0x1
-#define LCP32XX_TIMER_CNTR_TCR_RESET		0x2
+#define LPC32XX_TIMER_CNTR_TCR_EN		0x1
+#define LPC32XX_TIMER_CNTR_TCR_RESET		0x2
 
 /*
  * mcr register definitions
  */
-#define LCP32XX_TIMER_CNTR_MCR_MTCH(n)		(0x1 << ((n) * 3))
-#define LCP32XX_TIMER_CNTR_MCR_RESET(n)		(0x1 << (((n) * 3) + 1))
-#define LCP32XX_TIMER_CNTR_MCR_STOP(n)		(0x1 << (((n) * 3) + 2))
+#define LPC32XX_TIMER_CNTR_MCR_MTCH(n)		(0x1 << ((n) * 3))
+#define LPC32XX_TIMER_CNTR_MCR_RESET(n)		(0x1 << (((n) * 3) + 1))
+#define LPC32XX_TIMER_CNTR_MCR_STOP(n)		(0x1 << (((n) * 3) + 2))
 
 /*
  * Standard UART register offsets
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 630dd4a..791100b 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -33,7 +33,7 @@
 
 static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
 {
-	return (cycle_t)__raw_readl(LCP32XX_TIMER_TC(LPC32XX_TIMER1_BASE));
+	return (cycle_t)__raw_readl(LPC32XX_TIMER_TC(LPC32XX_TIMER1_BASE));
 }
 
 static struct clocksource lpc32xx_clksrc = {
@@ -48,11 +48,11 @@ static struct clocksource lpc32xx_clksrc = {
 static int lpc32xx_clkevt_next_event(unsigned long delta,
     struct clock_event_device *dev)
 {
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_RESET,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
-	__raw_writel(delta, LCP32XX_TIMER_PR(LPC32XX_TIMER0_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_RESET,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(delta, LPC32XX_TIMER_PR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_EN,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
 
 	return 0;
 }
@@ -72,7 +72,7 @@ static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
 		 * disable the timer to wait for the first call to
 		 * set_next_event().
 		 */
-		__raw_writel(0, LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+		__raw_writel(0, LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
 		break;
 
 	case CLOCK_EVT_MODE_UNUSED:
@@ -95,8 +95,8 @@ static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = &lpc32xx_clkevt;
 
 	/* Clear match */
-	__raw_writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
-		LCP32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_MTCH_BIT(0),
+		LPC32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
 
 	evt->event_handler(evt);
 
@@ -142,14 +142,14 @@ static void __init lpc32xx_timer_init(void)
 	clkrate = clkrate / clk_get_pclk_div();
 
 	/* Initial timer setup */
-	__raw_writel(0, LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
-		LCP32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
-	__raw_writel(1, LCP32XX_TIMER_MR0(LPC32XX_TIMER0_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_MCR_MTCH(0) |
-		LCP32XX_TIMER_CNTR_MCR_STOP(0) |
-		LCP32XX_TIMER_CNTR_MCR_RESET(0),
-		LCP32XX_TIMER_MCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(0, LPC32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_MTCH_BIT(0),
+		LPC32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
+	__raw_writel(1, LPC32XX_TIMER_MR0(LPC32XX_TIMER0_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_MCR_MTCH(0) |
+		LPC32XX_TIMER_CNTR_MCR_STOP(0) |
+		LPC32XX_TIMER_CNTR_MCR_RESET(0),
+		LPC32XX_TIMER_MCR(LPC32XX_TIMER0_BASE));
 
 	/* Setup tick interrupt */
 	setup_irq(IRQ_LPC32XX_TIMER0, &lpc32xx_timer_irq);
@@ -165,12 +165,12 @@ static void __init lpc32xx_timer_init(void)
 	clockevents_register_device(&lpc32xx_clkevt);
 
 	/* Use timer1 as clock source. */
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_RESET,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
-	__raw_writel(0, LCP32XX_TIMER_PR(LPC32XX_TIMER1_BASE));
-	__raw_writel(0, LCP32XX_TIMER_MCR(LPC32XX_TIMER1_BASE));
-	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
-		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_RESET,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
+	__raw_writel(0, LPC32XX_TIMER_PR(LPC32XX_TIMER1_BASE));
+	__raw_writel(0, LPC32XX_TIMER_MCR(LPC32XX_TIMER1_BASE));
+	__raw_writel(LPC32XX_TIMER_CNTR_TCR_EN,
+		LPC32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
 	lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
 		lpc32xx_clksrc.shift);
 	clocksource_register(&lpc32xx_clksrc);
-- 
1.7.1.1
