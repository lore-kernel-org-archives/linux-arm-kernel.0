From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 23 Sep 2018 17:23:51 +0200
Subject: [PATCH v2 2/7] dt-bindings: add power-domain header for RK3066 SoCs
In-Reply-To: <20180923152356.30154-1-heiko@sntech.de>
References: <20180923152356.30154-1-heiko@sntech.de>
Message-ID: <20180923152356.30154-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rk3066 power-domains as described by the TRM.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/power/rk3066-power.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3066-power.h

diff --git a/include/dt-bindings/power/rk3066-power.h b/include/dt-bindings/power/rk3066-power.h
new file mode 100644
index 000000000000..dd9bbd35c274
--- /dev/null
+++ b/include/dt-bindings/power/rk3066-power.h
@@ -0,0 +1,21 @@
+#ifndef __DT_BINDINGS_POWER_RK3066_POWER_H__
+#define __DT_BINDINGS_POWER_RK3066_POWER_H__
+
+/* VD_CORE */
+#define RK3066_PD_A9_0		0
+#define RK3066_PD_A9_1		1
+#define RK3066_PD_DBG		4
+#define RK3066_PD_SCU		5
+
+/* VD_LOGIC */
+#define RK3066_PD_VIDEO		6
+#define RK3066_PD_VIO		7
+#define RK3066_PD_GPU		8
+#define RK3066_PD_PERI		9
+#define RK3066_PD_CPU		10
+#define RK3066_PD_ALIVE		11
+
+/* VD_PMU */
+#define RK3066_PD_RTC		12
+
+#endif
-- 
2.18.0
