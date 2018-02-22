From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Thu, 22 Feb 2018 13:48:47 +0800
Subject: [PATCH v1 1/5] dt-bindings: soc: update MT2712 power dt-bindings
In-Reply-To: <20180222054851.26096-1-weiyi.lu@mediatek.com>
References: <20180222054851.26096-1-weiyi.lu@mediatek.com>
Message-ID: <20180222054851.26096-3-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new power domains(MFG_SC1/MFG_SC2/MFG_SC3)
for MT2712 according to ECO design change.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 include/dt-bindings/power/mt2712-power.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/power/mt2712-power.h b/include/dt-bindings/power/mt2712-power.h
index 92b46d772fae..2c147817efc2 100644
--- a/include/dt-bindings/power/mt2712-power.h
+++ b/include/dt-bindings/power/mt2712-power.h
@@ -22,5 +22,8 @@
 #define MT2712_POWER_DOMAIN_USB		5
 #define MT2712_POWER_DOMAIN_USB2	6
 #define MT2712_POWER_DOMAIN_MFG		7
+#define MT2712_POWER_DOMAIN_MFG_SC1	8
+#define MT2712_POWER_DOMAIN_MFG_SC2	9
+#define MT2712_POWER_DOMAIN_MFG_SC3	10
 
 #endif /* _DT_BINDINGS_POWER_MT2712_POWER_H */
-- 
2.12.5
