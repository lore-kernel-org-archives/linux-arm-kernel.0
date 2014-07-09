From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Jul 2014 12:41:11 +0100
Subject: [PATCH v3 2/5] phy: miphy365x: Add MiPHY365x header file for DT x
 Driver defines
In-Reply-To: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1404906074-31992-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides the shared header file which will be reference from both
the MiPHY365x driver and its associated Device Tree node(s).

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/dt-bindings/phy/phy-miphy365x.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-miphy365x.h

diff --git a/include/dt-bindings/phy/phy-miphy365x.h b/include/dt-bindings/phy/phy-miphy365x.h
new file mode 100644
index 0000000..8ef8aba
--- /dev/null
+++ b/include/dt-bindings/phy/phy-miphy365x.h
@@ -0,0 +1,14 @@
+/*
+ * This header provides constants for the phy framework
+ * based on the STMicroelectronics MiPHY365x.
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+#ifndef _DT_BINDINGS_PHY_MIPHY
+#define _DT_BINDINGS_PHY_MIPHY
+
+#define MIPHY_TYPE_SATA		1
+#define MIPHY_TYPE_PCIE		2
+#define MIPHY_TYPE_USB		3
+
+#endif /* _DT_BINDINGS_PHY_MIPHY */
-- 
1.8.3.2
