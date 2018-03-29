From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 29 Mar 2018 11:11:06 +0100
Subject: [PATCH] dt-bindings: rcar-dmac: Document r8a77470 support
Message-ID: <1522318266-45281-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas  RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
Document RZ/G1C (also known as R8A77470) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 891db41..b5e603c 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -18,6 +18,7 @@ Required Properties:
 	      Examples with soctypes are:
 		- "renesas,dmac-r8a7743" (RZ/G1M)
 		- "renesas,dmac-r8a7745" (RZ/G1E)
+		- "renesas,dmac-r8a77470" (RZ/G1C)
 		- "renesas,dmac-r8a7790" (R-Car H2)
 		- "renesas,dmac-r8a7791" (R-Car M2-W)
 		- "renesas,dmac-r8a7792" (R-Car V2H)
-- 
2.7.4
