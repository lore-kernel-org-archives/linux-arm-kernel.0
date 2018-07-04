From: mars.cheng@mediatek.com (Mars Cheng)
Date: Wed, 4 Jul 2018 09:52:51 +0800
Subject: [PATCH v3 1/4] dt-bindings: mediatek: add support for mt6765
 reference board
In-Reply-To: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1530669174-17623-2-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update binding document for mt6765 reference board

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..48fac4e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -11,6 +11,7 @@ compatible: Must contain one of
    "mediatek,mt6589"
    "mediatek,mt6592"
    "mediatek,mt6755"
+   "mediatek,mt6765"
    "mediatek,mt6795"
    "mediatek,mt6797"
    "mediatek,mt7622"
@@ -41,6 +42,9 @@ Supported boards:
 - Evaluation phone for MT6755(Helio P10):
     Required root node properties:
       - compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
+- Evaluation board for MT6765(Helio P22):
+    Required root node properties:
+      - compatible = "mediatek,mt6765-evb", "mediatek,mt6765";
 - Evaluation board for MT6795(Helio X10):
     Required root node properties:
       - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- 
1.7.9.5
