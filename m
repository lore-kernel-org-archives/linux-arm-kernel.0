From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Oct 2016 15:20:48 +0200
Subject: [PATCH 2/2] ARM: shmobile: r8a7793/gose: Add board part number to DT
 bindings
In-Reply-To: <1475587248-13670-1-git-send-email-geert+renesas@glider.be>
References: <1475587248-13670-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1475587248-13670-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 6c3ffc2ebeaa346a..18a20a7689c52342 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -47,7 +47,7 @@ Boards:
     compatible = "renesas,bockw", "renesas,r8a7778"
   - Genmai (RTK772100BC00000BR)
     compatible = "renesas,genmai", "renesas,r7s72100"
-  - Gose
+  - Gose (RTP0RC7793SEB00010S)
     compatible = "renesas,gose", "renesas,r8a7793"
   - H3ULCB (RTP0RC7795SKB00010S)
     compatible = "renesas,h3ulcb", "renesas,r8a7795";
-- 
1.9.1
