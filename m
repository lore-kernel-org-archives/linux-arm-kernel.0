From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:29 +0200
Subject: [PATCH 14/21] dt-bindings: power: rcar-sysc: Document r8a7744 SYSC
 binding
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <08ea4a3004da9dfbf361f6791934af58a35ec350.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add binding documentation for the RZ/G1N (R8A7744) SYSC block.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index 4cb97d48bf66..eae2a880155a 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -8,6 +8,7 @@ and various coprocessors.
 Required properties:
   - compatible: Must contain exactly one of the following:
       - "renesas,r8a7743-sysc" (RZ/G1M)
+      - "renesas,r8a7744-sysc" (RZ/G1N)
       - "renesas,r8a7745-sysc" (RZ/G1E)
       - "renesas,r8a77470-sysc" (RZ/G1C)
       - "renesas,r8a774a1-sysc" (RZ/G2M)
-- 
2.11.0
