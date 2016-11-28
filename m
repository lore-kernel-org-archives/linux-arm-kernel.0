From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 28 Nov 2016 16:50:26 +0100
Subject: [PATCH net-next v4 2/4] dt-bindings: net: add EEE capability constants
In-Reply-To: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1480348229-25672-3-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
Tested-by: Andreas F?rber <afaerber@suse.de>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/net/mdio.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/net/mdio.h

diff --git a/include/dt-bindings/net/mdio.h b/include/dt-bindings/net/mdio.h
new file mode 100644
index 000000000000..99c6d903d439
--- /dev/null
+++ b/include/dt-bindings/net/mdio.h
@@ -0,0 +1,19 @@
+/*
+ * This header provides generic constants for ethernet MDIO bindings
+ */
+
+#ifndef _DT_BINDINGS_NET_MDIO_H
+#define _DT_BINDINGS_NET_MDIO_H
+
+/*
+ * EEE capability Advertisement
+ */
+
+#define MDIO_EEE_100TX		0x0002	/* 100TX EEE cap */
+#define MDIO_EEE_1000T		0x0004	/* 1000T EEE cap */
+#define MDIO_EEE_10GT		0x0008	/* 10GT EEE cap */
+#define MDIO_EEE_1000KX		0x0010	/* 1000KX EEE cap */
+#define MDIO_EEE_10GKX4		0x0020	/* 10G KX4 EEE cap */
+#define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap */
+
+#endif
-- 
2.7.4
