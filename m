From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:32 +0200
Subject: [PATCH 17/21] dt-bindings: reset: rcar-rst: Document r8a7744 reset
 module
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <f1ae799039bfd3fcc046041714eb0ac227505d0f.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Document bindings for the RZ/G1N (R8A7744) reset module.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index 25e6db546215..b03c48a1150e 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -16,6 +16,7 @@ Required properties:
 		  - "renesas,<soctype>-rst" for R-Car Gen2 and Gen3, and RZ/G
 		Examples with soctypes are:
 		  - "renesas,r8a7743-rst" (RZ/G1M)
+		  - "renesas,r8a7744-rst" (RZ/G1N)
 		  - "renesas,r8a7745-rst" (RZ/G1E)
 		  - "renesas,r8a77470-rst" (RZ/G1C)
 		  - "renesas,r8a774a1-rst" (RZ/G2M)
-- 
2.11.0
