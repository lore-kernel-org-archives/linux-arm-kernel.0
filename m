From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 20 Dec 2017 17:47:05 +0800
Subject: [PATCH net 1/2] dt-bindings: net: mediatek: add condition to property
 mediatek, pctl
Message-ID: <e366efc29985d3292c8a1afb1389b5eac57c9037.1513762066.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The property "mediatek,pctl" is only required for SoCs such as MT2701 and
MT7623, so adding a few words for stating the condition.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/net/mediatek-net.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek-net.txt b/Documentation/devicetree/bindings/net/mediatek-net.txt
index 214eaa9..53c13ee 100644
--- a/Documentation/devicetree/bindings/net/mediatek-net.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-net.txt
@@ -28,7 +28,7 @@ Required properties:
 - mediatek,sgmiisys: phandle to the syscon node that handles the SGMII setup
 	which is required for those SoCs equipped with SGMII such as MT7622 SoC.
 - mediatek,pctl: phandle to the syscon node that handles the ports slew rate
-	and driver current
+	and driver current: only for MT2701 and MT7623 SoC
 
 Optional properties:
 - interrupt-parent: Should be the phandle for the interrupt controller
-- 
2.7.4
