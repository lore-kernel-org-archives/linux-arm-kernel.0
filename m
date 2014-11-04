From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue,  4 Nov 2014 11:51:18 +0100
Subject: [PATCH v5 2/8] phy: miphy28lp: Add PHY header file for DT x Driver
 defines
In-Reply-To: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1415098284-11182-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides the shared header file which will be reference from both
PHY driver and its associated Device Tree node(s).

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 include/dt-bindings/phy/phy.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy.h

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
new file mode 100644
index 0000000..e8c6a3f
--- /dev/null
+++ b/include/dt-bindings/phy/phy.h
@@ -0,0 +1,18 @@
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
+#define PHY_TYPE_USB2		3
+#define PHY_TYPE_USB3		4
+
+#endif /* _DT_BINDINGS_PHY */
-- 
1.9.1
