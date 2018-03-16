From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:59 +0100
Subject: [PATCH 3/8] dt-bindings: arm: Document Renesas H2-based Stout DT
 bindings
In-Reply-To: <cover.1521206902.git.horms+renesas@verge.net.au>
References: <cover.1521206902.git.horms+renesas@verge.net.au>
Message-ID: <584fc22ceeda11d5ac40b1659d4708314d3d2675.1521206902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Document the Renesas H2 Stout (ADAS Starterkit) device tree bindings,
listing it as a supported board.

This allows to use checkpatch.pl to validate .dts files referring to
the Stout board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 41d3920aaa5e..98916b3864c2 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -116,6 +116,8 @@ Boards:
     compatible = "renesas,sk-rzg1e", "renesas,r8a7745"
   - SK-RZG1M (YR8A77430S000BE)
     compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
+  - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
+    compatible = "renesas,stout", "renesas,r8a7790"
   - V3MSK
     compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat
-- 
2.11.0
