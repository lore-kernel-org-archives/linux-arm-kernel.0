From: jun.gao@mediatek.com (Jun Gao)
Date: Mon, 21 Aug 2017 11:36:52 +0800
Subject: [PATCH v4 1/3] dt-bindings: i2c: modify information formats
In-Reply-To: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1503286614-17670-2-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Use common name MediaTek and modify the compatible information
formats of all SoCs to the same.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index bd5a7be..9c86424 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -1,14 +1,14 @@
-* Mediatek's I2C controller
+* MediaTek's I2C controller
 
-The Mediatek's I2C controller is used to interface with I2C devices.
+The MediaTek's I2C controller is used to interface with I2C devices.
 
 Required properties:
   - compatible: value should be either of the following.
-      "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek mt2701
-      "mediatek,mt6577-i2c": for i2c compatible with mt6577.
-      "mediatek,mt6589-i2c": for i2c compatible with mt6589.
-      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for i2c compatible with mt7623.
-      "mediatek,mt8173-i2c": for i2c compatible with mt8173.
+      "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for MediaTek MT2701
+      "mediatek,mt6577-i2c": for MediaTek MT6577
+      "mediatek,mt6589-i2c": for MediaTek MT6589
+      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
+      "mediatek,mt8173-i2c": for MediaTek MT8173
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
-- 
1.8.1.1
