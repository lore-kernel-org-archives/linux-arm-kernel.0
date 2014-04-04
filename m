From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  4 Apr 2014 16:14:15 -0700
Subject: [PATCH v2 4/5] dt-bindings: clock: Add Zynq-7000 header
In-Reply-To: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1396653256-28397-5-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add header file with symbolic names for Zynq's clocks.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

Changes in v2:
 - this patch has been added

---
 include/dt-bindings/clock/zynq-7000.h | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/clock/zynq-7000.h

diff --git a/include/dt-bindings/clock/zynq-7000.h b/include/dt-bindings/clock/zynq-7000.h
new file mode 100644
index 000000000000..851f5cffe481
--- /dev/null
+++ b/include/dt-bindings/clock/zynq-7000.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2014 Xilinx Inc.
+ * Author: S?ren Brinkmann <soren.brinkmann@xilinx.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants for Zynq 7000 clock controller.
+*/
+
+#ifndef _DT_BINDINGS_CLOCK_ZYNQ_7000_H
+#define _DT_BINDINGS_CLOCK_ZYNQ_7000_H
+
+#define ZYNQ_CLK_ARMPLL		0
+#define ZYNQ_CLK_DDRPLL		1
+#define ZYNQ_CLK_IOPLL		2
+#define ZYNQ_CLK_CPU_6OR4X	3
+#define ZYNQ_CLK_CPU_3OR2X	4
+#define ZYNQ_CLK_CPU_2X		5
+#define ZYNQ_CLK_CPU_1X		6
+#define ZYNQ_CLK_DDR2X		7
+#define ZYNQ_CLK_DDR3X		8
+#define ZYNQ_CLK_DCI		9
+#define ZYNQ_CLK_LQSPI		10
+#define ZYNQ_CLK_SMC		11
+#define ZYNQ_CLK_PCAP		12
+#define ZYNQ_CLK_GEM0		13
+#define ZYNQ_CLK_GEM1		14
+#define ZYNQ_CLK_FCLK0		15
+#define ZYNQ_CLK_FCLK1		16
+#define ZYNQ_CLK_FCLK2		17
+#define ZYNQ_CLK_FCLK3		18
+#define ZYNQ_CLK_CAN0		19
+#define ZYNQ_CLK_CAN1		20
+#define ZYNQ_CLK_SDIO0		21
+#define ZYNQ_CLK_SDIO1		22
+#define ZYNQ_CLK_UART0		23
+#define ZYNQ_CLK_UART1		24
+#define ZYNQ_CLK_SPI0		25
+#define ZYNQ_CLK_SPI1		26
+#define ZYNQ_CLK_DMA		27
+#define ZYNQ_CLK_USB0_APER	28
+#define ZYNQ_CLK_USB1_APER	29
+#define ZYNQ_CLK_GEM0_APER	30
+#define ZYNQ_CLK_GEM1_APER	31
+#define ZYNQ_CLK_SDIO0_APER	32
+#define ZYNQ_CLK_SDIO1_APER	33
+#define ZYNQ_CLK_SPI0_APER	34
+#define ZYNQ_CLK_SPI1_APER	35
+#define ZYNQ_CLK_CAN0_APER	36
+#define ZYNQ_CLK_CAN1_APER	37
+#define ZYNQ_CLK_I2C0_APER	38
+#define ZYNQ_CLK_I2C1_APER	39
+#define ZYNQ_CLK_UART0_APER	40
+#define ZYNQ_CLK_UART1_APER	41
+#define ZYNQ_CLK_GPIO_APER	42
+#define ZYNQ_CLK_LQSPI_APER	43
+#define ZYNQ_CLK_SMC_APER	44
+#define ZYNQ_CLK_SWDT		45
+#define ZYNQ_CLK_DBG_TRC	46
+#define ZYNQ_CLK_DBG_APB	47
+
+#endif /* _DT_BINDINGS_CLOCK_ZYNQ_7000_H */
-- 
1.9.1.1.gbb9f595
