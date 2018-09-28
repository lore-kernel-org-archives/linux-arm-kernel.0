From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:34 +0200
Subject: [PATCH 19/21] dt-bindings: apmu: Document r8a77470 support
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <4619ef4747c23818063c4e8480d63966a40297c6.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document APMU and SMP enable method for RZ/G1C (also known as
r8a77470) SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,apmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
index f747f95eee58..e6f47c9b3d0e 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.txt
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -9,6 +9,7 @@ Required properties:
 	      Examples with soctypes are:
 		- "renesas,r8a7743-apmu" (RZ/G1M)
 		- "renesas,r8a7745-apmu" (RZ/G1E)
+		- "renesas,r8a77470-apmu" (RZ/G1C)
 		- "renesas,r8a7790-apmu" (R-Car H2)
 		- "renesas,r8a7791-apmu" (R-Car M2-W)
 		- "renesas,r8a7792-apmu" (R-Car V2H)
-- 
2.11.0
