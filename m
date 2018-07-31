From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 31 Jul 2018 13:37:58 +0800
Subject: [PATCH v4 01/10] dt-bindings: arm: Add bindings for Mediatek MT8183
 SoC Platform
In-Reply-To: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1533015487-60189-2-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds dt-binding documentation of cpu for Mediatek MT8183.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..2754535 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -19,6 +19,7 @@ compatible: Must contain one of
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
+   "mediatek,mt8183"
 
 
 Supported boards:
@@ -73,3 +74,6 @@ Supported boards:
 - MTK mt8173 tablet EVB:
     Required root node properties:
       - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
+- Evaluation board for MT8183:
+    Required root node properties:
+      - compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
-- 
1.9.1
