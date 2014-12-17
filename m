From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 17 Dec 2014 22:17:30 +0800
Subject: [PATCH v2 1/4] Document: DT: Add bindings for mediatek MT8173 Soc
 Platform
In-Reply-To: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
References: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1418825853-10934-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the devicetree binding document for mediatek MT8173 SoC.
This is a 64-bit four core Soc.
And mt8173-evb is a evaluation board based on mt8173.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 1ca713e..622c5d9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -8,6 +8,7 @@ compatible: Must contain one of
    "mediatek,mt6589"
    "mediatek,mt8127"
    "mediatek,mt8135"
+   "mediatek,mt8173"
 
 
 Supported boards:
@@ -21,3 +22,6 @@ Supported boards:
 - MTK mt8135 tablet EVB:
     Required root node properties:
       - compatible = "mediatek,mt8135-evbp1", "mediatek,mt8135";
+- MTK mt8173 tablet EVB:
+    Required root node properties:
+      - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
-- 
1.8.1.1.dirty
