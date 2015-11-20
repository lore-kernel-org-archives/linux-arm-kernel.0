From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:05:03 +0200
Subject: [PATCH 03/11] dt-bindings: clock: add NXP LPC32xx clock list for
 consumers
In-Reply-To: <1447981511-29653-1-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
Message-ID: <1447981511-29653-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds a list of NXP LPC32xx clocks, which can be requested
by clock consumers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 include/dt-bindings/clock/lpc32xx-clock.h | 56 +++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/dt-bindings/clock/lpc32xx-clock.h

diff --git a/include/dt-bindings/clock/lpc32xx-clock.h b/include/dt-bindings/clock/lpc32xx-clock.h
new file mode 100644
index 0000000..6f4036a
--- /dev/null
+++ b/include/dt-bindings/clock/lpc32xx-clock.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2015 Vladimir Zapolskiy <vz@mleia.com>
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ *
+ */
+
+#ifndef __DT_BINDINGS_LPC32XX_CLOCK_H
+#define __DT_BINDINGS_LPC32XX_CLOCK_H
+
+/* LPC32XX System Control Block clocks */
+#define LPC32XX_CLK_RTC		0
+#define LPC32XX_CLK_DMA		1
+#define LPC32XX_CLK_MLC		2
+#define LPC32XX_CLK_SLC		3
+#define LPC32XX_CLK_LCD		4
+#define LPC32XX_CLK_MAC		5
+#define LPC32XX_CLK_SD		6
+#define LPC32XX_CLK_DDRAM	7
+#define LPC32XX_CLK_SSP0	8
+#define LPC32XX_CLK_SSP1	9
+#define LPC32XX_CLK_UART3	10
+#define LPC32XX_CLK_UART4	11
+#define LPC32XX_CLK_UART5	12
+#define LPC32XX_CLK_UART6	13
+#define LPC32XX_CLK_IRDA	14
+#define LPC32XX_CLK_I2C1	15
+#define LPC32XX_CLK_I2C2	16
+#define LPC32XX_CLK_TIMER0	17
+#define LPC32XX_CLK_TIMER1	18
+#define LPC32XX_CLK_TIMER2	19
+#define LPC32XX_CLK_TIMER3	20
+#define LPC32XX_CLK_TIMER4	21
+#define LPC32XX_CLK_TIMER5	22
+#define LPC32XX_CLK_WDOG	23
+#define LPC32XX_CLK_I2S0	24
+#define LPC32XX_CLK_I2S1	25
+#define LPC32XX_CLK_SPI1	26
+#define LPC32XX_CLK_SPI2	27
+#define LPC32XX_CLK_MCPWM	28
+#define LPC32XX_CLK_HSTIMER	29
+#define LPC32XX_CLK_KEY		30
+#define LPC32XX_CLK_PWM1	31
+#define LPC32XX_CLK_PWM2	32
+#define LPC32XX_CLK_ADC		33
+
+/* LPC32XX USB clocks */
+#define LPC32XX_USB_CLK_I2C	0
+#define LPC32XX_USB_CLK_DEVICE	1
+#define LPC32XX_USB_CLK_HOST	2
+
+#endif /* __DT_BINDINGS_LPC32XX_CLOCK_H */
-- 
2.1.4
