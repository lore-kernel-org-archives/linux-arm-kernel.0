From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed,  4 Jan 2017 08:19:14 +0800
Subject: [PATCH v5 1/4] soc: zte: Add header for PM domains specifiers
Message-ID: <1483489157-10782-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds header with values used for ZTE 2967
SoC's power domain driver.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
---
 include/dt-bindings/soc/zte,pm_domains.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/dt-bindings/soc/zte,pm_domains.h

diff --git a/include/dt-bindings/soc/zte,pm_domains.h b/include/dt-bindings/soc/zte,pm_domains.h
new file mode 100644
index 0000000..01e9abc
--- /dev/null
+++ b/include/dt-bindings/soc/zte,pm_domains.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2017 Linaro Ltd.
+ *
+ * Author: Baoyou Xie <baoyou.xie@linaro.org>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#ifndef _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H
+#define _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H
+
+#define DM_ZX296718_SAPPU	0
+#define DM_ZX296718_VDE		1  /* g1v6 */
+#define DM_ZX296718_VCE		2  /* h1v6 */
+#define DM_ZX296718_HDE		3  /* g2v2 */
+#define DM_ZX296718_VIU		4
+#define DM_ZX296718_USB20	5
+#define DM_ZX296718_USB21	6
+#define DM_ZX296718_USB30	7
+#define DM_ZX296718_HSIC	8
+#define DM_ZX296718_GMAC	9
+#define DM_ZX296718_TS		10
+#define DM_ZX296718_VOU		11
+
+#endif /* _DT_BINDINGS_SOC_ZTE_PM_DOMAINS_H */
-- 
2.7.4
