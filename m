From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Apr 2016 13:44:49 +1000
Subject: [PATCH 7/7] soc: renesas: Add r8a7795 SYSC PM Domain Binding
 Definitions
In-Reply-To: <cover.1461210185.git.horms+renesas@verge.net.au>
References: <cover.1461210185.git.horms+renesas@verge.net.au>
Message-ID: <839a04d847f5871516f500091519c52dc40fe01d.1461210185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/power/r8a7795-sysc.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a7795-sysc.h

diff --git a/include/dt-bindings/power/r8a7795-sysc.h b/include/dt-bindings/power/r8a7795-sysc.h
new file mode 100644
index 000000000000..ee2e26ba605e
--- /dev/null
+++ b/include/dt-bindings/power/r8a7795-sysc.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A7795_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A7795_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A7795_PD_CA57_CPU0		 0
+#define R8A7795_PD_CA57_CPU1		 1
+#define R8A7795_PD_CA57_CPU2		 2
+#define R8A7795_PD_CA57_CPU3		 3
+#define R8A7795_PD_CA53_CPU0		 5
+#define R8A7795_PD_CA53_CPU1		 6
+#define R8A7795_PD_CA53_CPU2		 7
+#define R8A7795_PD_CA53_CPU3		 8
+#define R8A7795_PD_A3VP			 9
+#define R8A7795_PD_CA57_SCU		12
+#define R8A7795_PD_CR7			13
+#define R8A7795_PD_A3VC			14
+#define R8A7795_PD_3DG_A		17
+#define R8A7795_PD_3DG_B		18
+#define R8A7795_PD_3DG_C		19
+#define R8A7795_PD_3DG_D		20
+#define R8A7795_PD_CA53_SCU		21
+#define R8A7795_PD_3DG_E		22
+#define R8A7795_PD_A3IR			24
+#define R8A7795_PD_A2VC0		25
+#define R8A7795_PD_A2VC1		26
+
+/* Always-on power area */
+#define R8A7795_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A7795_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
