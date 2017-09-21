From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Sep 2017 11:44:59 +0200
Subject: [PATCH] ARM: shmobile: remove inconsistent ; from documentation
Message-ID: <1505987099-19944-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consistently do not suffix compat string documentation with a ';'

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Based on renesas-devel-20170921-v4.14-rc1

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 4fa984ada912..020d758fc0c5 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -69,7 +69,7 @@ Boards:
     compatible = "renesas,gose", "renesas,r8a7793"
   - H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKBX0010SA00 (H3 ES1.1))
     H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
-    compatible = "renesas,h3ulcb", "renesas,r8a7795";
+    compatible = "renesas,h3ulcb", "renesas,r8a7795"
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
   - iWave Systems RZ/G1E SODIMM SOM Development Platform (iW-RainboW-G22D)
@@ -91,7 +91,7 @@ Boards:
   - Lager (RTP0RC7790SEB00010S)
     compatible = "renesas,lager", "renesas,r8a7790"
   - M3ULCB (R-Car Starter Kit Pro, RTP0RC7796SKBX0010SA09 (M3 ES1.0))
-    compatible = "renesas,m3ulcb", "renesas,r8a7796";
+    compatible = "renesas,m3ulcb", "renesas,r8a7796"
   - Marzen (R0P7779A00010S)
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Porter (M2-LCDP)
@@ -99,11 +99,11 @@ Boards:
   - RSKRZA1 (YR0K77210C000BE)
     compatible = "renesas,rskrza1", "renesas,r7s72100"
   - Salvator-X (RTP0RC7795SIPB0010S)
-    compatible = "renesas,salvator-x", "renesas,r8a7795";
+    compatible = "renesas,salvator-x", "renesas,r8a7795"
   - Salvator-X (RTP0RC7796SIPB0011S)
-    compatible = "renesas,salvator-x", "renesas,r8a7796";
+    compatible = "renesas,salvator-x", "renesas,r8a7796"
   - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
-    compatible = "renesas,salvator-xs", "renesas,r8a7795";
+    compatible = "renesas,salvator-xs", "renesas,r8a7795"
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
   - SK-RZG1E (YR8A77450S000BE)
-- 
2.1.4
