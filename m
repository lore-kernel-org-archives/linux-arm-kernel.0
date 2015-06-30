From: mars.cheng@mediatek.com (Mars Cheng)
Date: Tue, 30 Jun 2015 15:02:30 +0800
Subject: [PATCH v2 1/2] Document: DT: Add bindings for mediatek MT6580 SoC
 Platform
In-Reply-To: <1435647751-20422-1-git-send-email-mars.cheng@mediatek.com>
References: <1435647751-20422-1-git-send-email-mars.cheng@mediatek.com>
Message-ID: <1435647751-20422-2-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DT binding documentation for the MT6580 SoC from Mediatek.

Change-Id: I608738d330d356291b581203befcfe69c3a846c1
Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index dd7550a..2daa424 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -5,6 +5,7 @@ Boards with a MediaTek mt65xx/mt81xx SoC shall have the following property:
 Required root node property:
 
 compatible: Must contain one of
+   "mediatek,mt6580"
    "mediatek,mt6589"
    "mediatek,mt6592"
    "mediatek,mt8127"
@@ -14,6 +15,9 @@ compatible: Must contain one of
 
 Supported boards:
 
+- Evaluation board for MT6580:
+    Required root node properties:
+      - compatible = "mediatek,mt6580-evbp1", "mediatek,mt6580";
 - bq Aquaris5 smart phone:
     Required root node properties:
       - compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
-- 
1.8.1.1.dirty
