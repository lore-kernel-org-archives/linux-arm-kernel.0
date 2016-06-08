From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 10:00:11 +0900
Subject: [PATCH 1/3] soc: renesas: rcar-sysc: Document r8a7796 support
In-Reply-To: <cover.1465347345.git.horms+renesas@verge.net.au>
References: <cover.1465347345.git.horms+renesas@verge.net.au>
Message-ID: <2ff1bf77e4d437be502b79443906fcb23e09b81b.1465347345.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
index b74e4d4785ab..0725fb37a973 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -14,6 +14,7 @@ Required properties:
       - "renesas,r8a7793-sysc" (R-Car M2-N)
       - "renesas,r8a7794-sysc" (R-Car E2)
       - "renesas,r8a7795-sysc" (R-Car H3)
+      - "renesas,r8a7796-sysc" (R-Car M3-W)
   - reg: Address start and address range for the device.
   - #power-domain-cells: Must be 1.
 
-- 
2.1.4
