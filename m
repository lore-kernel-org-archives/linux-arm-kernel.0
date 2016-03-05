From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 18:02:52 +0000
Subject: [PATCH 4/5] ARM: bcm2835: add defines for each DREQ
In-Reply-To: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
References: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457200973-11662-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Define names for each of the DMA DREQ values.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 include/dt-bindings/dma/bcm2835.h | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 include/dt-bindings/dma/bcm2835.h

diff --git a/include/dt-bindings/dma/bcm2835.h b/include/dt-bindings/dma/bcm2835.h
new file mode 100644
index 0000000..5bade32
--- /dev/null
+++ b/include/dt-bindings/dma/bcm2835.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2016 Martin Sperl
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/* DREQ definitions */
+#define BCM2835_DMA_DREQ_NONE		0
+#define BCM2835_DMA_DREQ_DSI0		1
+#define BCM2835_DMA_DREQ_PCM_TX		2
+#define BCM2835_DMA_DREQ_PCM_RX		3
+#define BCM2835_DMA_DREQ_SMI		4
+#define BCM2835_DMA_DREQ_PWM		5
+#define BCM2835_DMA_DREQ_SPI_TX		6
+#define BCM2835_DMA_DREQ_SPI_RX		7
+#define BCM2835_DMA_DREQ_BSC_TX		8
+#define BCM2835_DMA_DREQ_BSC_RX		9
+#define BCM2835_DMA_DREQ_UNUSED		10
+#define BCM2835_DMA_DREQ_EMMC		11
+#define BCM2835_DMA_DREQ_UART_TX	12
+#define BCM2835_DMA_DREQ_SDHOST		13
+#define BCM2835_DMA_DREQ_UART_RX	14
+#define BCM2835_DMA_DREQ_DSI1		15
+#define BCM2835_DMA_DREQ_SLIM_MC_TX	16
+#define BCM2835_DMA_DREQ_HDMI		17
+#define BCM2835_DMA_DREQ_SLIM_MC_RX	18
+#define BCM2835_DMA_DREQ_SLIM_DC0	19
+#define BCM2835_DMA_DREQ_SLIM_DC1	20
+#define BCM2835_DMA_DREQ_SLIM_DC2	21
+#define BCM2835_DMA_DREQ_SLIM_DC3	22
+#define BCM2835_DMA_DREQ_SLIM_DC4	23
+#define BCM2835_DMA_DREQ_SCALER_FIFO0	24
+#define BCM2835_DMA_DREQ_SCALER_FIFO1	25
+#define BCM2835_DMA_DREQ_SCALER_FIFO2	26
+#define BCM2835_DMA_DREQ_SLIM_DC5	27
+#define BCM2835_DMA_DREQ_SLIM_DC6	28
+#define BCM2835_DMA_DREQ_SLIM_DC7	29
+#define BCM2835_DMA_DREQ_SLIM_DC8	30
+#define BCM2835_DMA_DREQ_SLIM_DC9	31
-- 
2.1.4
