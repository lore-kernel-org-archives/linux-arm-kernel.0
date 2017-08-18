From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Aug 2017 10:20:07 +0200
Subject: [PATCH 3/3] dt-bindings: apmu: Document r8a7743 support
In-Reply-To: <cover.1502961902.git.horms+renesas@verge.net.au>
References: <cover.1502961902.git.horms+renesas@verge.net.au>
Message-ID: <304ce59242e11e715bfdc86577771502df99f7cd.1502961902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Document APMU and SMP enable method for RZ/G1M
(also known as r8a7743) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/power/renesas,apmu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.txt b/Documentation/devicetree/bindings/power/renesas,apmu.txt
index 84404c9edff7..af21502e939c 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.txt
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.txt
@@ -1,12 +1,13 @@
 DT bindings for the Renesas Advanced Power Management Unit
 
-Renesas R-Car line of SoCs utilize one or more APMU hardware units
+Renesas R-Car and RZ/G1 SoCs utilize one or more APMU hardware units
 for CPU core power domain control including SMP boot and CPU Hotplug.
 
 Required properties:
 
 - compatible: Should be "renesas,<soctype>-apmu", "renesas,apmu" as fallback.
 	      Examples with soctypes are:
+		- "renesas,r8a7743-apmu" (RZ/G1M)
 		- "renesas,r8a7790-apmu" (R-Car H2)
 		- "renesas,r8a7791-apmu" (R-Car M2-W)
 		- "renesas,r8a7792-apmu" (R-Car V2H)
-- 
2.1.4
