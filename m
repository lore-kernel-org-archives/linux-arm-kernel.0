From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:47 +0200
Subject: [PATCH 1/4] dt-bindings: arm: Document RZ/G2M SoC DT bindings
In-Reply-To: <cover.1538129305.git.horms+renesas@verge.net.au>
References: <cover.1538129305.git.horms+renesas@verge.net.au>
Message-ID: <01588646dbce3bf9a79a190f3949677067cc1e20.1538129305.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add device tree bindings documentation for Renesas RZ/G2M (r8a774a1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 89b4a389fbc7..8acd3cd819b3 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -23,6 +23,8 @@ SoCs:
     compatible = "renesas,r8a7745"
   - RZ/G1C (R8A77470)
     compatible = "renesas,r8a77470"
+  - RZ/G2M (R8A774A1)
+    compatible = "renesas,r8a774a1"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
   - R-Car H1 (R8A77790)
-- 
2.11.0
