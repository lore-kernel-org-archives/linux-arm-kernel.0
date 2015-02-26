From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:05 +0900
Subject: [PATCH 04/12] ARM: shmobile: mackerel: Remove DT binding documentation
In-Reply-To: <cover.1424931560.git.horms+renesas@verge.net.au>
References: <cover.1424931560.git.horms+renesas@verge.net.au>
Message-ID: <1da7d6f424f7dfc557d019a172c08af0365c5739.1424931560.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the DT compatible string documentation for the
no longer supported Mackerel board.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 51147cb..095e4d1 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -61,8 +61,6 @@ Boards:
     compatible = "renesas,kzm9g-reference", "renesas,sh73a0"
   - Lager (RTP0RC7790SEB00010S)
     compatible = "renesas,lager", "renesas,r8a7790"
-  - Mackerel (R0P7372LC0016RL, AP4 EVM 2nd)
-    compatible = "renesas,mackerel"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
 
-- 
2.1.4
