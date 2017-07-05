From: biju.das@bp.renesas.com (Biju Das)
Date: Wed,  5 Jul 2017 16:56:28 +0100
Subject: [PATCH v2 1/2] ravb: Document binding for r8a7743 SoC
In-Reply-To: <1499270189-29945-1-git-send-email-biju.das@bp.renesas.com>
References: <afcd181c-c805-8f3c-955f-652d001a03d4@cogentembedded.com>
 <1499270189-29945-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499270189-29945-2-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new compatible string for the RZ/G1M (R8A7743) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index b519503..bc692ab 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -4,7 +4,8 @@ This file provides information on what the device node for the Ethernet AVB
 interface contains.
 
 Required properties:
-- compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
+- compatible: "renesas,etheravb-r8a7743" if the device is a part of R8A7743 SoC.
+	      "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,etheravb-r8a7791" if the device is a part of R8A7791 SoC.
 	      "renesas,etheravb-r8a7792" if the device is a part of R8A7792 SoC.
 	      "renesas,etheravb-r8a7793" if the device is a part of R8A7793 SoC.
-- 
1.9.1
