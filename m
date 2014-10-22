From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 22 Oct 2014 09:14:21 +0200
Subject: [PATCH v4 2/8] phy: miphy28lp: Add PHY header file for DT x Driver
 defines
In-Reply-To: <1413962067-25557-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1413962067-25557-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1413962067-25557-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides the shared header file which will be reference from both
PHY driver and its associated Device Tree node(s).

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 include/dt-bindings/phy/phy.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy.h

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
new file mode 100644
index 0000000..a142c69
--- /dev/null
+++ b/include/dt-bindings/phy/phy.h
@@ -0,0 +1,17 @@
+/*
+ *
+ * This header provides constants for the phy framework
+ *
+ * Copyright (C) 2014 STMicroelectronics
+ * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _DT_BINDINGS_PHY
+#define _DT_BINDINGS_PHY
+
+#define PHY_TYPE_SATA		1
+#define PHY_TYPE_PCIE		2
+#define PHY_TYPE_USB		3
+
+#endif /* _DT_BINDINGS_PHY */
-- 
1.9.1
