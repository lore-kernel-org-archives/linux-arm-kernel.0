From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 19:03:42 +0100
Subject: [PATCH 1/4] dt-bindings: arm: Document SoC compatible value for
 Armadillo-800 EVA
In-Reply-To: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
References: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519668225-12548-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible property of the root node in a DTS for Atmark Techno
Armadillo-800 EVA should include the compatible value for the R-Mobile
A1 SoC, too.

Fixes: d2c2a0776899ba2d ("ARM: shmobile: Add platform device tree bindings documentation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 63edc11e83ef287f..ded2cd3b5f4df0c8 100644
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
2.7.4
