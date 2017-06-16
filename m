From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:58 +0200
Subject: [PATCH 5/5] ARM: shmobile: Document Renesas H3-based Salvator-XS
 board DT bindings
In-Reply-To: <cover.1497617896.git.horms+renesas@verge.net.au>
References: <cover.1497617896.git.horms+renesas@verge.net.au>
Message-ID: <521ec12e2f56b16e6a0b4e7ef97a666bd3de4ff5.1497617896.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Renesas Salvator-XS (Salvator-X 2nd version) development board can
be equipped with either an R-Car H3 ES2.0 or M3-W ES1.x SiP, which are
pin-compatible.

Document board part number and compatible values for the version with
R-Car H3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 433f25afe288..d95324a88ee6 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -86,6 +86,8 @@ Boards:
     compatible = "renesas,salvator-x", "renesas,r8a7795";
   - Salvator-X (RTP0RC7796SIPB0011S)
     compatible = "renesas,salvator-x", "renesas,r8a7796";
+  - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
+    compatible = "renesas,salvator-xs", "renesas,r8a7795";
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
   - SK-RZG1E (YR8A77450S000BE)
-- 
2.1.4
