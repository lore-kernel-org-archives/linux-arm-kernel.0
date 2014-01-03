From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  3 Jan 2014 11:10:50 +0100
Subject: [PATCH v1 05/24] gpio: zynq: Add dummy gpio routines
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <72795c2d0788847db1b062f8d2c1f6958773e81c.1388743861.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagannadha Sutradharudu Teki <jagannadha.sutradharudu-teki@xilinx.com>

GPIO dummy routines are required for fdt build, may be removed
these dependencies once the u-boot fdt is fully optimized.

Signed-off-by: Jagannadha Sutradharudu Teki <jaganna@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v1: None

 arch/arm/include/asm/arch-zynq/gpio.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-zynq/gpio.h

diff --git a/arch/arm/include/asm/arch-zynq/gpio.h b/arch/arm/include/asm/arch-zynq/gpio.h
new file mode 100644
index 0000000..2dbba75
--- /dev/null
+++ b/arch/arm/include/asm/arch-zynq/gpio.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2013 Xilinx, Inc.
+ *
+ * SPDX-License-Identifier:	GPL-2.0+
+ */
+
+#ifndef _ZYNQ_GPIO_H
+#define _ZYNQ_GPIO_H
+
+inline int gpio_get_value(unsigned gpio)
+{
+	return 0;
+}
+
+inline int gpio_set_value(unsigned gpio, int val)
+{
+	return 0;
+}
+
+inline int gpio_request(unsigned gpio, const char *label)
+{
+	return 0;
+}
+
+#endif /* _ZYNQ_GPIO_H */
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/24e55534/attachment.sig>
