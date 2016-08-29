From: chris.brandt@renesas.com (Chris Brandt)
Date: Mon, 29 Aug 2016 14:14:29 -0400
Subject: [PATCH] ARM: shmobile: Add RSKRZA1 DT bindings documentation
Message-ID: <20160829181429.25115-1-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RSKRZA1 Device tree bindings Documentation, listing it as a supported
board.

This allows to use checkpatch to validate DTSes referring to the RSKRZA1
board.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 1df32d3..2192b1c 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -63,6 +63,8 @@ Boards:
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Porter (M2-LCDP)
     compatible = "renesas,porter", "renesas,r8a7791"
+  - RSKRZA1 (YR0K77210C000BE)
+    compatible = "renesas,rskrza1", "renesas,r7s72100"
   - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795";
   - Salvator-X
-- 
2.9.2
