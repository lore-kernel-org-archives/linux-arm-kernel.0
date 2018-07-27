From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 28 Jul 2018 00:15:21 +0530
Subject: [PATCH 3/9] dt-bindings: reset: Add binding constants for Actions
 Semi S700 RMU
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180727184527.13287-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding constants for Actions Semi S700 SoC Reset
Management Unit (RMU).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dt-bindings/reset/actions,s700-reset.h    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/reset/actions,s700-reset.h

diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
new file mode 100644
index 000000000000..5e3b16b8ef53
--- /dev/null
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+//
+// Device Tree binding constants for Actions Semi S700 Reset Management Unit
+//
+// Copyright (c) 2018 Linaro Ltd.
+
+#ifndef __DT_BINDINGS_ACTIONS_S700_RESET_H
+#define __DT_BINDINGS_ACTIONS_S700_RESET_H
+
+#define RESET_AUDIO				0
+#define RESET_CSI				1
+#define RESET_DE				2
+#define RESET_DSI				3
+#define RESET_GPIO				4
+#define RESET_I2C0				5
+#define RESET_I2C1				6
+#define RESET_I2C2				7
+#define RESET_I2C3				8
+#define RESET_KEY				9
+#define RESET_LCD0				10
+#define RESET_SI				11
+#define RESET_SPI0				12
+#define RESET_SPI1				13
+#define RESET_SPI2				14
+#define RESET_SPI3				15
+#define RESET_UART0				16
+#define RESET_UART1				17
+#define RESET_UART2				18
+#define RESET_UART3				19
+#define RESET_UART4				20
+#define RESET_UART5				21
+#define RESET_UART6				22
+
+#endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.17.1
