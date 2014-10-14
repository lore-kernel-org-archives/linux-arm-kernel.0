From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 11:12:55 +0200
Subject: [PATCH 2/8] dt: bindings: ux500: Add header for PM domains specifiers
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413277981-27451-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/dt-bindings/arm/ux500_pm_domains.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 include/dt-bindings/arm/ux500_pm_domains.h

diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
new file mode 100644
index 0000000..398a6c0
--- /dev/null
+++ b/include/dt-bindings/arm/ux500_pm_domains.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#ifndef _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
+#define _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
+
+#define DOMAIN_VAPE		0
+
+/* Number of PM domains. */
+#define NR_DOMAINS		(DOMAIN_VAPE + 1)
+
+#endif
-- 
1.9.1
