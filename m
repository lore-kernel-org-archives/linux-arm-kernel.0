From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:25:45 +0800
Subject: [PATCH v2 01/30] pinctrl: mediatek: Add missing pinctrl bindings for
 mt7623
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-2-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add missing pinctrl binding these which would be used in
devicetree related files.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/dt-bindings/pinctrl/mt7623-pinfunc.h | 30 ++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/pinctrl/mt7623-pinfunc.h b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
index 2f00bdc..436a87b 100644
--- a/include/dt-bindings/pinctrl/mt7623-pinfunc.h
+++ b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
@@ -185,6 +185,12 @@
 #define MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO (MTK_PIN_NO(56) | 1)
 #define MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MI (MTK_PIN_NO(56) | 2)
 
+#define MT7623_PIN_57_SDA1_FUNC_GPIO57 (MTK_PIN_NO(57) | 0)
+#define MT7623_PIN_57_SDA1_FUNC_SDA1 (MTK_PIN_NO(57) | 1)
+
+#define MT7623_PIN_58_SCL1_FUNC_GPIO58 (MTK_PIN_NO(58) | 0)
+#define MT7623_PIN_58_SCL1_FUNC_SCL1 (MTK_PIN_NO(58) | 1)
+
 #define MT7623_PIN_60_WB_RSTB_FUNC_GPIO60 (MTK_PIN_NO(60) | 0)
 #define MT7623_PIN_60_WB_RSTB_FUNC_WB_RSTB (MTK_PIN_NO(60) | 1)
 
@@ -244,6 +250,22 @@
 #define MT7623_PIN_76_SCL0_FUNC_GPIO76 (MTK_PIN_NO(76) | 0)
 #define MT7623_PIN_76_SCL0_FUNC_SCL0 (MTK_PIN_NO(76) | 1)
 
+#define MT7623_PIN_79_URXD0_FUNC_GPIO79 (MTK_PIN_NO(79) | 0)
+#define MT7623_PIN_79_URXD0_FUNC_URXD0 (MTK_PIN_NO(79) | 1)
+#define MT7623_PIN_79_URXD0_FUNC_UTXD0 (MTK_PIN_NO(79) | 2)
+
+#define MT7623_PIN_80_UTXD0_FUNC_GPIO80 (MTK_PIN_NO(80) | 0)
+#define MT7623_PIN_80_UTXD0_FUNC_UTXD0 (MTK_PIN_NO(80) | 1)
+#define MT7623_PIN_80_UTXD0_FUNC_URXD0 (MTK_PIN_NO(80) | 2)
+
+#define MT7623_PIN_81_URXD1_FUNC_GPIO81 (MTK_PIN_NO(81) | 0)
+#define MT7623_PIN_81_URXD1_FUNC_URXD1 (MTK_PIN_NO(81) | 1)
+#define MT7623_PIN_81_URXD1_FUNC_UTXD1 (MTK_PIN_NO(81) | 2)
+
+#define MT7623_PIN_82_UTXD1_FUNC_GPIO82 (MTK_PIN_NO(82) | 0)
+#define MT7623_PIN_82_UTXD1_FUNC_UTXD1 (MTK_PIN_NO(82) | 1)
+#define MT7623_PIN_82_UTXD1_FUNC_URXD1 (MTK_PIN_NO(82) | 2)
+
 #define MT7623_PIN_83_LCM_RST_FUNC_GPIO83 (MTK_PIN_NO(83) | 0)
 #define MT7623_PIN_83_LCM_RST_FUNC_LCM_RST (MTK_PIN_NO(83) | 1)
 
@@ -351,10 +373,10 @@
 #define MT7623_PIN_122_GPIO122_FUNC_SDA2 (MTK_PIN_NO(122) | 4)
 #define MT7623_PIN_122_GPIO122_FUNC_URXD0 (MTK_PIN_NO(122) | 5)
 
-#define MT7623_PIN_123_GPIO123_FUNC_GPIO123 (MTK_PIN_NO(123) | 0)
-#define MT7623_PIN_123_GPIO123_FUNC_TEST (MTK_PIN_NO(123) | 1)
-#define MT7623_PIN_123_GPIO123_FUNC_SCL2 (MTK_PIN_NO(123) | 4)
-#define MT7623_PIN_123_GPIO123_FUNC_UTXD0 (MTK_PIN_NO(123) | 5)
+#define MT7623_PIN_123_HTPLG_FUNC_GPIO123 (MTK_PIN_NO(123) | 0)
+#define MT7623_PIN_123_HTPLG_FUNC_HTPLG (MTK_PIN_NO(123) | 1)
+#define MT7623_PIN_123_HTPLG_FUNC_SCL2 (MTK_PIN_NO(123) | 4)
+#define MT7623_PIN_123_HTPLG_FUNC_UTXD0 (MTK_PIN_NO(123) | 5)
 
 #define MT7623_PIN_124_GPIO124_FUNC_GPIO124 (MTK_PIN_NO(124) | 0)
 #define MT7623_PIN_124_GPIO124_FUNC_TEST (MTK_PIN_NO(124) | 1)
-- 
1.9.1
