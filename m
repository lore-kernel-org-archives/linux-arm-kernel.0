From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:58:04 +0900
Subject: [PATCH 27/28] ARM: shmobile: fix SILK board name
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <7265405f74b33f256073ea233690b6ee866c252c.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Unfortunately, the SILK board bindings were not quite correct, as the  board
name should be all caps.  Fix that,  adding the board model #  in parens and
removing stray semicolon.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index a9148b1dcd96..40bb9007cd0d 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -57,5 +57,5 @@ Boards:
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Porter (M2-LCDP)
     compatible = "renesas,porter", "renesas,r8a7791"
-  - Silk
-    compatible = "renesas,silk", "renesas,r8a7794";
+  - SILK (RTP0RC7794LCB00011S)
+    compatible = "renesas,silk", "renesas,r8a7794"
-- 
2.1.4
