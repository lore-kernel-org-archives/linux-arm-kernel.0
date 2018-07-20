From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:06:04 +0200
Subject: [PATCH 1/2] dt-bindings: arm: Document the RZN1D-DB board
In-Reply-To: <cover.1532081674.git.horms+renesas@verge.net.au>
References: <cover.1532081674.git.horms+renesas@verge.net.au>
Message-ID: <403cc7037f3858c3029fdf7629960516c7d3aced.1532081674.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michel Pollet <michel.pollet@bp.renesas.com>

This documents the RZ/N1 bindings for the RZN1D-DB board.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index d8cf740132c6..89b4a389fbc7 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -51,7 +51,8 @@ SoCs:
     compatible = "renesas,r8a77990"
   - R-Car D3 (R8A77995)
     compatible = "renesas,r8a77995"
-
+  - RZ/N1D (R9A06G032)
+    compatible = "renesas,r9a06g032"
 
 Boards:
 
@@ -112,6 +113,8 @@ Boards:
     compatible = "renesas,porter", "renesas,r8a7791"
   - RSKRZA1 (YR0K77210C000BE)
     compatible = "renesas,rskrza1", "renesas,r7s72100"
+  - RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
+    compatible = "renesas,rzn1d400-db", "renesas,r9a06g032"
   - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795"
   - Salvator-X (RTP0RC7796SIPB0011S)
-- 
2.11.0
