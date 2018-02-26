From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 19:03:45 +0100
Subject: [PATCH 4/4] dt-bindings: arm: Document Renesas R-Car M3-N-based
 Salvator-XS board
In-Reply-To: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
References: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519668225-12548-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Renesas Salvator-XS development board can be equipped with an R-Car
H3, M3-W, or M3-N SiP, which are pin-compatible.

Document board part number and compatible values for the version with
R-Car M3-N.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 51e4428856be4557..303f04e639431837 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -114,6 +114,8 @@ Boards:
     compatible = "renesas,salvator-xs", "renesas,r8a7795"
   - Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
     compatible = "renesas,salvator-xs", "renesas,r8a7796"
+  - Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
+    compatible = "renesas,salvator-xs", "renesas,r8a77965"
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
   - SK-RZG1E (YR8A77450S000BE)
-- 
2.7.4
