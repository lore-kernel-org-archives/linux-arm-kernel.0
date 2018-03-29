From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 29 Mar 2018 11:02:55 +0100
Subject: [PATCH net-next] dt-bindings: net: renesas-ravb: Add support for
 r8a77470 SoC
Message-ID: <1522317775-35671-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible string for the RZ/G1C (R8A77470) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index b4dc455..c306f55 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible: Must contain one or more of the following:
       - "renesas,etheravb-r8a7743" for the R8A7743 SoC.
       - "renesas,etheravb-r8a7745" for the R8A7745 SoC.
+      - "renesas,etheravb-r8a77470" for the R8A77470 SoC.
       - "renesas,etheravb-r8a7790" for the R8A7790 SoC.
       - "renesas,etheravb-r8a7791" for the R8A7791 SoC.
       - "renesas,etheravb-r8a7792" for the R8A7792 SoC.
-- 
2.7.4
