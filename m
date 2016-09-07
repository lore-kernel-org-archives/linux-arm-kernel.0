From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:50:02 +0200
Subject: [PATCH 15/26] ARM: dts: Add RSKRZA1 DT bindings documentation
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <16a304d8297245e4bc0e863395b8fea593d81e09.1473234372.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add RSKRZA1 Device tree bindings Documentation, listing it as a supported
board.

This allows to use checkpatch to validate DTSes referring to the RSKRZA1
board.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 90cf237ee558..5484c31d555f 100644
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
2.7.0.rc3.207.g0ac5344
