From: jun.gao@mediatek.com (Jun Gao)
Date: Wed, 15 Feb 2017 10:32:55 +0800
Subject: [PATCH v2 1/2] Documentation: devicetree: Add i2c binding for
 mediatek MT2701 Soc Platform
In-Reply-To: <1487125976-25243-1-git-send-email-jun.gao@mediatek.com>
References: <1487125976-25243-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1487125976-25243-2-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Add i2c DT binding to i2c-mt6577.txt for MT2701 and there is no need to modify i2c driver.

Change-Id: I892f866d755aa3865bffd1a80884cd41b6ecc1f1
Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
index 0ce6fa3..ef22ecf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
@@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
 
 Required properties:
   - compatible: value should be either of the following.
-      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
-      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
-      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
-      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
-      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
+	"mediatek,mt2701-i2c", for i2c compatible with mt2701 i2c.
+	"mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
+	"mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
+	"mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
+	"mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
+	"mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
-- 
1.7.9.5
