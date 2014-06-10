From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:33 +0200
Subject: [PATCH 20/24] dt: bindings: ux500: Add header for power domains
 specifiers
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-21-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/dt-bindings/arm/ux500_pm_domains.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 include/dt-bindings/arm/ux500_pm_domains.h

diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
new file mode 100644
index 0000000..73cf25a
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
+/* Number of power domains. */
+#define NR_DOMAINS		(DOMAIN_VAPE + 1)
+
+#endif
-- 
1.7.9.5
