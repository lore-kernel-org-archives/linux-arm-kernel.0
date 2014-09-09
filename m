From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue,  9 Sep 2014 18:51:03 +0200
Subject: [PATCH v3 6/7] arm: dts: mediatek: Add compatible property for
 aquaris5
In-Reply-To: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
References: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1410281464-9587-7-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing 'compatible' property to device tree root node of

 - mt6589-aquaris5.dts

and document the new values.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 6 ++++++
 arch/arm/boot/dts/mt6589-aquaris5.dts              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index d6ac71f..fa25226 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -6,3 +6,9 @@ Required root node property:
 
 compatible: must contain "mediatek,mt6589"
 
+
+Supported boards:
+
+- bq Aquaris5 smart phone:
+    Required root node properties:
+      - compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
diff --git a/arch/arm/boot/dts/mt6589-aquaris5.dts b/arch/arm/boot/dts/mt6589-aquaris5.dts
index 74cb1ba..0da0470 100644
--- a/arch/arm/boot/dts/mt6589-aquaris5.dts
+++ b/arch/arm/boot/dts/mt6589-aquaris5.dts
@@ -18,6 +18,7 @@
 
 / {
 	model = "bq Aquaris5";
+	compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
 
 	chosen {
 		bootargs = "earlyprintk";
-- 
1.9.1
