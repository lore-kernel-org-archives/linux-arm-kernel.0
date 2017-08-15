From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 15 Aug 2017 15:40:20 +0100
Subject: [PATCH ] dt-bindings: net: ravb : Add support for r8a7745 SoC
Message-ID: <1502808020-22406-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible string for the RZ/G1E (R8A7745) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch is tested against linux-next tag next-20170815
as well as net-next.

 Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 4717bc2..1672353 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -6,6 +6,7 @@ interface contains.
 Required properties:
 - compatible: Must contain one or more of the following:
       - "renesas,etheravb-r8a7743" for the R8A7743 SoC.
+      - "renesas,etheravb-r8a7745" for the R8A7745 SoC.
       - "renesas,etheravb-r8a7790" for the R8A7790 SoC.
       - "renesas,etheravb-r8a7791" for the R8A7791 SoC.
       - "renesas,etheravb-r8a7792" for the R8A7792 SoC.
-- 
1.9.1
