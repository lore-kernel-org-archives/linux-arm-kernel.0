From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:40 +0100
Subject: [PATCH 6/9] ARM: shmobile: r8a7793/gose: Add board part number to DT
 bindings
In-Reply-To: <cover.1478251657.git.horms+renesas@verge.net.au>
References: <cover.1478251657.git.horms+renesas@verge.net.au>
Message-ID: <4b8f5955be83c539d2defe0a81313c11c0e3b3ad.1478251657.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 106b542c27c9..15669642b532 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -49,7 +49,7 @@ Boards:
     compatible = "renesas,bockw", "renesas,r8a7778"
   - Genmai (RTK772100BC00000BR)
     compatible = "renesas,genmai", "renesas,r7s72100"
-  - Gose
+  - Gose (RTP0RC7793SEB00010S)
     compatible = "renesas,gose", "renesas,r8a7793"
   - H3ULCB (RTP0RC7795SKB00010S)
     compatible = "renesas,h3ulcb", "renesas,r8a7795";
-- 
2.7.0.rc3.207.g0ac5344
