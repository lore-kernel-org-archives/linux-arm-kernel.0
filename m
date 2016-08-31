From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 31 Aug 2016 11:17:34 +0200
Subject: [PATCH] arm64: renesas: r8a7796/salvator-x: Add board part number to
 DT bindings
Message-ID: <1472635054-24372-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 90cf237ee5581978..42a046a97acba00f 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -65,7 +65,7 @@ Boards:
     compatible = "renesas,porter", "renesas,r8a7791"
   - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795";
-  - Salvator-X
+  - Salvator-X (RTP0RC7796SIPB0011S)
     compatible = "renesas,salvator-x", "renesas,r8a7796";
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
-- 
1.9.1
