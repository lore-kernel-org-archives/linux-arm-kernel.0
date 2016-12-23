From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 23 Dec 2016 11:47:50 +0800
Subject: [PATCH v1 1/3] dt/bindings: power: add RK3328 SoCs header for
 idle-request
In-Reply-To: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
References: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1482464872-12954-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to a description from TRM, add all the idle request.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/power/rk3328-power.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3328-power.h

diff --git a/include/dt-bindings/power/rk3328-power.h b/include/dt-bindings/power/rk3328-power.h
new file mode 100644
index 000000000000..10c3c3715334
--- /dev/null
+++ b/include/dt-bindings/power/rk3328-power.h
@@ -0,0 +1,18 @@
+#ifndef __DT_BINDINGS_POWER_RK3328_POWER_H__
+#define __DT_BINDINGS_POWER_RK3328_POWER_H__
+
+/**
+ * RK3328 idle id Summary.
+ */
+#define RK3328_PD_CORE		0
+#define RK3328_PD_GPU		1
+#define RK3328_PD_BUS		2
+#define RK3328_PD_MSCH		3
+#define RK3328_PD_PERI		4
+#define RK3328_PD_VIDEO		5
+#define RK3328_PD_HEVC		6
+#define RK3328_PD_SYS		7
+#define RK3328_PD_VPU		8
+#define RK3328_PD_VIO		9
+
+#endif
-- 
1.9.1
