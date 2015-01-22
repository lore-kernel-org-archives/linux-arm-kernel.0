From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Jan 2015 09:48:46 +0000
Subject: [PATCH v2 RESEND 1/8] dt: bindings: Supply shared ST IRQ defines
In-Reply-To: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1421920133-7914-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These defines are used to allow values used for configuration to be
easily human readable and will lessen the chance of logical mistakes.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/dt-bindings/interrupt-controller/irq-st.h | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/irq-st.h

diff --git a/include/dt-bindings/interrupt-controller/irq-st.h b/include/dt-bindings/interrupt-controller/irq-st.h
new file mode 100644
index 0000000..4c59ace
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/irq-st.h
@@ -0,0 +1,30 @@
+/*
+ *  include/linux/irqchip/irq-st.h
+ *
+ *  Copyright (C) 2014 STMicroelectronics ? All Rights Reserved
+ *
+ *  Author: Lee Jones <lee.jones@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ST_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ST_H
+
+#define ST_IRQ_SYSCFG_EXT_0		0
+#define ST_IRQ_SYSCFG_EXT_1		1
+#define ST_IRQ_SYSCFG_EXT_2		2
+#define ST_IRQ_SYSCFG_CTI_0		3
+#define ST_IRQ_SYSCFG_CTI_1		4
+#define ST_IRQ_SYSCFG_PMU_0		5
+#define ST_IRQ_SYSCFG_PMU_1		6
+#define ST_IRQ_SYSCFG_pl310_L2		7
+#define ST_IRQ_SYSCFG_DISABLED		0xFFFFFFFF
+
+#define ST_IRQ_SYSCFG_EXT_1_INV		0x1
+#define ST_IRQ_SYSCFG_EXT_2_INV		0x2
+#define ST_IRQ_SYSCFG_EXT_3_INV		0x4
+
+#endif
-- 
1.9.1
