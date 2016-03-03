From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu,  3 Mar 2016 16:03:51 +0800
Subject: [PATCH v5 4/6] dt/bindings: power: add RK3399 SoCs header for
 power-domain
In-Reply-To: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
References: <1456992233-25164-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1456992233-25164-5-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to a description from TRM, add all the power domains

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/power/rk3399-power.h | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 include/dt-bindings/power/rk3399-power.h

diff --git a/include/dt-bindings/power/rk3399-power.h b/include/dt-bindings/power/rk3399-power.h
new file mode 100644
index 0000000..69fbd67
--- /dev/null
+++ b/include/dt-bindings/power/rk3399-power.h
@@ -0,0 +1,53 @@
+#ifndef __DT_BINDINGS_POWER_RK3399_POWER_H__
+#define __DT_BINDINGS_POWER_RK3399_POWER_H__
+
+/* VD_CORE_L */
+#define RK3399_PD_A53_L0	0
+#define RK3399_PD_A53_L1	1
+#define RK3399_PD_A53_L2	2
+#define RK3399_PD_A53_L3	3
+#define RK3399_PD_SCU_L		4
+
+/* VD_CORE_B */
+#define RK3399_PD_A72_B0	5
+#define RK3399_PD_A72_B1	6
+#define RK3399_PD_SCU_B		7
+
+/* VD_CENTER */
+#define RK3399_PD_CENTER	8
+#define RK3399_PD_VCODEC	9
+#define RK3399_PD_RGA		10
+#define RK3399_PD_IEP		11
+#define RK3399_PD_VDU		12
+
+/* VD_LOGIC */
+#define RK3399_PD_PERILP	13
+#define RK3399_PD_PERIHP	14
+#define RK3399_PD_VIO		15
+#define RK3399_PD_VO		16
+#define RK3399_PD_VOPB		17
+#define RK3399_PD_VOPL		18
+#define RK3399_PD_ISP0		19
+#define RK3399_PD_ISP1		20
+#define RK3399_PD_HDCP		21
+#define RK3399_PD_TCPD0		22
+#define RK3399_PD_TCPD1		23
+#define RK3399_PD_GIC		24
+#define RK3399_PD_ALIVE		25
+#define RK3399_PD_USB3		26
+#define RK3399_PD_SD		27
+#define RK3399_PD_CCI		28
+#define RK3399_PD_CCI0		29
+#define RK3399_PD_CCI1		30
+#define RK3399_PD_GMAC		31
+#define RK3399_PD_EMMC		32
+#define RK3399_PD_EDP		33
+#define RK3399_PD_SDIOAUDIO	34
+
+/* VD_GPU */
+#define RK3399_PD_GPU		35
+
+/* VD_PMU */
+#define RK3399_PD_PMU		36
+
+#endif
-- 
1.9.1
