From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 27 Apr 2018 16:14:45 +0800
Subject: [PATCH v2 4/6] dt-bindings: reset: mediatek: add entry for Mali-450
 node to refer
In-Reply-To: <cover.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
Message-ID: <d9f327fa30c987ac9cf3a349551bbaa037d1b24a.1524816502.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Just add binding for a required reset referenced by Mali-450 on MT7623
or MT2701 SoC.

Cc: devicetree at vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/dt-bindings/reset/mt2701-resets.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/mt2701-resets.h b/include/dt-bindings/reset/mt2701-resets.h
index 21deb54..50b7f06 100644
--- a/include/dt-bindings/reset/mt2701-resets.h
+++ b/include/dt-bindings/reset/mt2701-resets.h
@@ -87,4 +87,7 @@
 #define MT2701_ETHSYS_GMAC_RST			23
 #define MT2701_ETHSYS_PPE_RST			31
 
+/* G3DSYS resets */
+#define MT2701_G3DSYS_CORE_RST			0
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT2701 */
-- 
2.7.4
