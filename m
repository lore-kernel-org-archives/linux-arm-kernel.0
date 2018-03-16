From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:04 +0100
Subject: [PATCH 8/8] dt-bindings: arm: Document Renesas R-Car M3-N-based
 Salvator-X board
In-Reply-To: <cover.1521206902.git.horms+renesas@verge.net.au>
References: <cover.1521206902.git.horms+renesas@verge.net.au>
Message-ID: <09bea76aad76058d7d1dae8f5804751a017967c1.1521206902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Renesas Salvator-X development board can be equipped with an R-Car
H3, M3-W, or M3-N SiP, which are pin-compatible.

Document board part number and compatible values for the version with
R-Car M3-N.

The board part number was extracted from a big patch by Takeshi Kihara
in the BSP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 02c77e58301b..d3d1df97834f 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -108,6 +108,8 @@ Boards:
     compatible = "renesas,salvator-x", "renesas,r8a7795"
   - Salvator-X (RTP0RC7796SIPB0011S)
     compatible = "renesas,salvator-x", "renesas,r8a7796"
+  - Salvator-X (RTP0RC7796SIPB0011S (M3N))
+    compatible = "renesas,salvator-x", "renesas,r8a77965"
   - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
     compatible = "renesas,salvator-xs", "renesas,r8a7795"
   - Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
-- 
2.11.0
