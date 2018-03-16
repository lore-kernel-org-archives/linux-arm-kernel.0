From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:01 +0100
Subject: [PATCH 5/8] dt-bindings: arm: Document SoC compatible value for
 Armadillo-800 EVA
In-Reply-To: <cover.1521206902.git.horms+renesas@verge.net.au>
References: <cover.1521206902.git.horms+renesas@verge.net.au>
Message-ID: <4a4b0f176b848e5050d75cacbdcf9aa86bef7848.1521206902.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The compatible property of the root node in a DTS for Atmark Techno
Armadillo-800 EVA should include the compatible value for the R-Mobile
A1 SoC, too.

Fixes: d2c2a0776899ba2d ("ARM: shmobile: Add platform device tree bindings documentation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 63edc11e83ef..a99359e63b0a 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -56,7 +56,7 @@ Boards:
   - APE6-EVM
     compatible = "renesas,ape6evm", "renesas,r8a73a4"
   - Atmark Techno Armadillo-800 EVA
-    compatible = "renesas,armadillo800eva"
+    compatible = "renesas,armadillo800eva", "renesas,r8a7740"
   - Blanche (RTP0RC7792SEB00010S)
     compatible = "renesas,blanche", "renesas,r8a7792"
   - BOCK-W
-- 
2.11.0
