From: jun.gao@mediatek.com (Jun Gao)
Date: Tue, 19 Dec 2017 14:51:01 +0800
Subject: [PATCH 1/3] dt-bindings: i2c: Add MediaTek MT2712 i2c binding
In-Reply-To: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Add MT2712 i2c binding to binding file. Compare to MT8173 i2c
controller, MT2712 has timing adjust registers which can adjust
the internal divider of i2c source clock, SCL duty cycle, SCL
compare point, start(repeated start) and stop time, SDA change
time.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index ff7bf37..e199695 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -5,6 +5,7 @@ The MediaTek's I2C controller is used to interface with I2C devices.
 Required properties:
   - compatible: value should be either of the following.
       "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for MediaTek MT2701
+      "mediatek,mt2712-i2c": for MediaTek MT2712
       "mediatek,mt6577-i2c": for MediaTek MT6577
       "mediatek,mt6589-i2c": for MediaTek MT6589
       "mediatek,mt7622-i2c": for MediaTek MT7622
-- 
1.8.1.1
