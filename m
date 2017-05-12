From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 12 May 2017 15:56:40 +0800
Subject: [PATCH v3 3/9] dt-bindings: arm: mediatek: update for MT7623n SoC and
 relevant boards
In-Reply-To: <cover.1494574682.git.sean.wang@mediatek.com>
References: <cover.1494574682.git.sean.wang@mediatek.com>
Message-ID: <e8f5dc8578c3980ac9c6411ad7fae1c8d747f567.1494574682.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Because there are two versions of MT7623 SoC that is MT7623a and MT7623n
respectively. So update the part of MT7623n bindings to allow that people
tend to differentiate which MT7623 SoC the boards applies.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index c860b24..0924b62 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -1,6 +1,6 @@
 MediaTek mt65xx, mt67xx & mt81xx Platforms Device Tree Bindings
 
-Boards with a MediaTek mt65xx/mt67xx/mt81xx SoC shall have the
+Boards with a MediaTek mt65xx/mt67xx/mt762x/mt81xx SoC shall have the
 following property:
 
 Required root node property:
@@ -12,7 +12,7 @@ compatible: Must contain one of
    "mediatek,mt6592"
    "mediatek,mt6755"
    "mediatek,mt6795"
-   "mediatek,mt7623"
+   "mediatek,mt7623" which is referred to MT7623N SoC
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
@@ -38,9 +38,9 @@ Supported boards:
 - Evaluation board for MT6795(Helio X10):
     Required root node properties:
       - compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
-- Evaluation board for MT7623:
+- Reference  board for MT7623n with NAND:
     Required root node properties:
-      - compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
+      - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
 - MTK mt8127 tablet moose EVB:
     Required root node properties:
       - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
-- 
2.7.4
