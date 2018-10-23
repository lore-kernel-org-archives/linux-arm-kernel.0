From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 Oct 2018 12:38:14 +0200
Subject: [PATCH v3 1/7] dt-bindings: add power-domain header for RK3188 SoCs
In-Reply-To: <20181023103820.6464-1-heiko@sntech.de>
References: <20181023103820.6464-1-heiko@sntech.de>
Message-ID: <20181023103820.6464-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rk3188 power-domains as described by the TRM.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/power/rk3188-power.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3188-power.h

diff --git a/include/dt-bindings/power/rk3188-power.h b/include/dt-bindings/power/rk3188-power.h
new file mode 100644
index 000000000000..93d23dfba33f
--- /dev/null
+++ b/include/dt-bindings/power/rk3188-power.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_POWER_RK3188_POWER_H__
+#define __DT_BINDINGS_POWER_RK3188_POWER_H__
+
+/* VD_CORE */
+#define RK3188_PD_A9_0		0
+#define RK3188_PD_A9_1		1
+#define RK3188_PD_A9_2		2
+#define RK3188_PD_A9_3		3
+#define RK3188_PD_DBG		4
+#define RK3188_PD_SCU		5
+
+/* VD_LOGIC */
+#define RK3188_PD_VIDEO		6
+#define RK3188_PD_VIO		7
+#define RK3188_PD_GPU		8
+#define RK3188_PD_PERI		9
+#define RK3188_PD_CPU		10
+#define RK3188_PD_ALIVE		11
+
+/* VD_PMU */
+#define RK3188_PD_RTC		12
+
+#endif
-- 
2.18.0
