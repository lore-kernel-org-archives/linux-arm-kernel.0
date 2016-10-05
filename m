From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:27:09 +0200
Subject: [RESEND PATCH v2 2/3] dt-bindings: reset: oxnas: Add include file
 with reset indexes
In-Reply-To: <20161005152710.2898-1-narmstrong@baylibre.com>
References: <20161005152710.2898-1-narmstrong@baylibre.com>
Message-ID: <20161005152710.2898-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT include file for Oxford Semiconductor OX810SE and OX820 reset
controller support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/reset/oxsemi,ox810se.h | 53 ++++++++++++++++++++++++++++++
 include/dt-bindings/reset/oxsemi,ox820.h   | 53 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 include/dt-bindings/reset/oxsemi,ox810se.h
 create mode 100644 include/dt-bindings/reset/oxsemi,ox820.h

diff --git a/include/dt-bindings/reset/oxsemi,ox810se.h b/include/dt-bindings/reset/oxsemi,ox810se.h
new file mode 100644
index 0000000..960c26e
--- /dev/null
+++ b/include/dt-bindings/reset/oxsemi,ox810se.h
@@ -0,0 +1,53 @@
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
+#ifndef DT_RESET_OXSEMI_OX810SE_H
+#define DT_RESET_OXSEMI_OX810SE_H
+
+#define RESET_ARM	0
+#define RESET_COPRO	1
+/* Reserved		2 */
+/* Reserved		3 */
+#define RESET_USBHS	4
+#define RESET_USBHSPHY	5
+#define RESET_MAC	6
+#define RESET_PCI	7
+#define RESET_DMA	8
+#define RESET_DPE	9
+#define RESET_DDR	10
+#define RESET_SATA	11
+#define RESET_SATA_LINK	12
+#define RESET_SATA_PHY	13
+ /* Reserved		14 */
+#define RESET_NAND	15
+#define RESET_GPIO	16
+#define RESET_UART1	17
+#define RESET_UART2	18
+#define RESET_MISC	19
+#define RESET_I2S	20
+#define RESET_AHB_MON	21
+#define RESET_UART3	22
+#define RESET_UART4	23
+#define RESET_SGDMA	24
+/* Reserved		25 */
+/* Reserved		26 */
+/* Reserved		27 */
+/* Reserved		28 */
+/* Reserved		29 */
+/* Reserved		30 */
+#define RESET_BUS	31
+
+#endif /* DT_RESET_OXSEMI_OX810SE_H */
diff --git a/include/dt-bindings/reset/oxsemi,ox820.h b/include/dt-bindings/reset/oxsemi,ox820.h
new file mode 100644
index 0000000..cc6797b
--- /dev/null
+++ b/include/dt-bindings/reset/oxsemi,ox820.h
@@ -0,0 +1,53 @@
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
+#ifndef DT_RESET_OXSEMI_OX820_H
+#define DT_RESET_OXSEMI_OX820_H
+
+#define RESET_SCU	0
+#define RESET_LEON	1
+#define RESET_ARM0	2
+#define RESET_ARM1	3
+#define RESET_USBHS	4
+#define RESET_USBPHYA	5
+#define RESET_MAC	6
+#define RESET_PCIEA	7
+#define RESET_SGDMA	8
+#define RESET_CIPHER	9
+#define RESET_DDR	10
+#define RESET_SATA	11
+#define RESET_SATA_LINK	12
+#define RESET_SATA_PHY	13
+#define RESET_PCIEPHY	14
+#define RESET_NAND	15
+#define RESET_GPIO	16
+#define RESET_UART1	17
+#define RESET_UART2	18
+#define RESET_MISC	19
+#define RESET_I2S	20
+#define RESET_SD	21
+#define RESET_MAC_2	22
+#define RESET_PCIEB	23
+#define RESET_VIDEO	24
+#define RESET_DDR_PHY	25
+#define RESET_USBPHYB	26
+#define RESET_USBDEV	27
+/* Reserved		29 */
+#define RESET_ARMDBG	29
+#define RESET_PLLA	30
+#define RESET_PLLB	31
+
+#endif /* DT_RESET_OXSEMI_OX820_H */
-- 
2.7.0
