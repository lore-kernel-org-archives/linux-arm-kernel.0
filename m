From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:17:47 +0100
Subject: [PATCH 05/16] arm64: renesas: r8a7796/salvator-x: Add board part
 number to DT bindings
In-Reply-To: <cover.1483700694.git.horms+renesas@verge.net.au>
References: <cover.1483700694.git.horms+renesas@verge.net.au>
Message-ID: <6be91f865660d56081fe67e969a4adf71c24cada.1483700694.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 253bf9b86690..c9502634316d 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -75,7 +75,7 @@ Boards:
     compatible = "renesas,rskrza1", "renesas,r7s72100"
   - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795";
-  - Salvator-X
+  - Salvator-X (RTP0RC7796SIPB0011S)
     compatible = "renesas,salvator-x", "renesas,r8a7796";
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
-- 
2.7.0.rc3.207.g0ac5344
