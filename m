From: yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 22 Oct 2014 18:29:54 +0800
Subject: [PATCH v4 5/8] dt-bindings: add more chips in documentation for
 Mediatek SoC
In-Reply-To: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1413973797-17619-6-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

Add MT8127 & MT8135 from Mediatek.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index fa25226..1ca713e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -1,10 +1,13 @@
-Mediatek MT6589 Platforms Device Tree Bindings
+Mediatek Platforms Device Tree Bindings
 
-Boards with a SoC of the Mediatek MT6589 shall have the following property:
+Boards with a SoC of the Mediatek shall have the following property:
 
 Required root node property:
 
-compatible: must contain "mediatek,mt6589"
+compatible: Must contain one of
+   "mediatek,mt6589"
+   "mediatek,mt8127"
+   "mediatek,mt8135"
 
 
 Supported boards:
@@ -12,3 +15,9 @@ Supported boards:
 - bq Aquaris5 smart phone:
     Required root node properties:
       - compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
+- MTK mt8127 tablet moose EVB:
+    Required root node properties:
+      - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
+- MTK mt8135 tablet EVB:
+    Required root node properties:
+      - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
-- 
1.8.1.1.dirty
