From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:48 +0200
Subject: [PATCH 6/6] dt-bindings: arm: document Renesas V3HSK board bindings
In-Reply-To: <cover.1526549153.git.horms+renesas@verge.net.au>
References: <cover.1526549153.git.horms+renesas@verge.net.au>
Message-ID: <c92db4a4a4c6c176c34604e456d6d355803d9ada.1526549153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Document the V3H Starter Kit device tree bindings, listing it as
a supported board.

This allows to use checkpatch.pl to validate .dts files referring to
the V3HSK board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 0da876784dd5..593a7d82a1c8 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -130,6 +130,8 @@ Boards:
     compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
   - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
     compatible = "renesas,stout", "renesas,r8a7790"
+  - V3HSK (Y-ASK-RCAR-V3H-WS10)
+    compatible = "renesas,v3hsk", "renesas,r8a77980"
   - V3MSK (Y-ASK-RCAR-V3M-WS10)
     compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat (RTP0RC7792ASKB0000JE)
-- 
2.11.0
