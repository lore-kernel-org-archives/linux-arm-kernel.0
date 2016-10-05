From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:07:48 +0200
Subject: [PATCH 2/6] clk: oxnas: Add dt-bindings include file for OX820
In-Reply-To: <20161005150752.22618-1-narmstrong@baylibre.com>
References: <20161005150752.22618-1-narmstrong@baylibre.com>
Message-ID: <20161005150752.22618-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the Oxford Semiconductor Gate clocks, add a
dedicated dt-binding include file for gate indexes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/oxsemi,ox820.h | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/clock/oxsemi,ox820.h

diff --git a/include/dt-bindings/clock/oxsemi,ox820.h b/include/dt-bindings/clock/oxsemi,ox820.h
new file mode 100644
index 0000000..f661ecc
--- /dev/null
+++ b/include/dt-bindings/clock/oxsemi,ox820.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef DT_CLOCK_OXSEMI_OX820_H
+#define DT_CLOCK_OXSEMI_OX820_H
+
+/* PLLs */
+#define CLK_820_PLLA		0
+#define CLK_820_PLLB		1
+
+/* Gate Clocks */
+#define CLK_820_LEON		2
+#define CLK_820_DMA_SGDMA	3
+#define CLK_820_CIPHER		4
+#define CLK_820_SD		5
+#define CLK_820_SATA		6
+#define CLK_820_AUDIO		7
+#define CLK_820_USBMPH		8
+#define CLK_820_ETHA		9
+#define CLK_820_PCIEA		10
+#define CLK_820_NAND		11
+#define CLK_820_PCIEB		12
+#define CLK_820_ETHB		13
+#define CLK_820_REF600		14
+#define CLK_820_USBDEV		15
+
+#endif /* DT_CLOCK_OXSEMI_OX820_H */
-- 
2.7.0
