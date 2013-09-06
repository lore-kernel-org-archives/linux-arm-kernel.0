From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 06 Sep 2013 12:12:39 +0200
Subject: [PATCH v2 10/12] ARM: exynos5440: create a DT header defining CLK IDs
In-Reply-To: <1378462361-13680-1-git-send-email-a.hajda@samsung.com>
References: <1378462361-13680-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1378462361-13680-11-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds header file defining clock IDs.
This allows to use macros instead of magic numbers in DT bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/dt-bindings/clock/exynos5440.h | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/dt-bindings/clock/exynos5440.h

diff --git a/include/dt-bindings/clock/exynos5440.h b/include/dt-bindings/clock/exynos5440.h
new file mode 100644
index 0000000..e2a0c61
--- /dev/null
+++ b/include/dt-bindings/clock/exynos5440.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Author: Andrzej Haja <a.hajda@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Device Tree binding constants for Exynos5440 clock controller.
+*/
+
+#ifndef _DT_BINDINGS_CLOCK_EXYNOS_5440_H
+#define _DT_BINDINGS_CLOCK_EXYNOS_5440_H
+
+#define CLK_XTAL		1
+#define CLK_ARM_CLK		2
+#define CLK_SPI_BAUD		16
+#define CLK_PB0_250		17
+#define CLK_PR0_250		18
+#define CLK_PR1_250		19
+#define CLK_B_250		20
+#define CLK_B_125		21
+#define CLK_B_200		22
+#define CLK_SATA		23
+#define CLK_USB			24
+#define CLK_GMAC0		25
+#define CLK_CS250		26
+#define CLK_PB0_250_O		27
+#define CLK_PR0_250_O		28
+#define CLK_PR1_250_O		29
+#define CLK_B_250_O		30
+#define CLK_B_125_O		31
+#define CLK_B_200_O		32
+#define CLK_SATA_O		33
+#define CLK_USB_O		34
+#define CLK_GMAC0_O		35
+#define CLK_CS250_O		36
+
+/* must be greater than maximal clock id */
+#define CLK_NR_CLKS		37
+
+#endif /* _DT_BINDINGS_CLOCK_EXYNOS_5440_H */
-- 
1.8.1.2
