From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2018 12:25:04 +0100
Subject: [PATCH 2/3] dt-bindings: arm: Fix RZ/G2E part number
In-Reply-To: <cover.1541514075.git.horms+renesas@verge.net.au>
References: <cover.1541514075.git.horms+renesas@verge.net.au>
Message-ID: <058ad7b6aa5204d3af878415c7b946748ab34f7a.1541514075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Fix RZ/G2E part number from its description.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index f5e0f82fd503..58c4256d37a3 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -27,7 +27,7 @@ SoCs:
     compatible = "renesas,r8a77470"
   - RZ/G2M (R8A774A1)
     compatible = "renesas,r8a774a1"
-  - RZ/G2E (RA8774C0)
+  - RZ/G2E (R8A774C0)
     compatible = "renesas,r8a774c0"
   - R-Car M1A (R8A77781)
     compatible = "renesas,r8a7778"
-- 
2.11.0
