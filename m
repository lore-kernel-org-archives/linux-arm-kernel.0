From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:04:43 +0100
Subject: [PATCH 04/18] arm64: dts: h3ulcb: update documentation with official
 board name
In-Reply-To: <cover.1479388193.git.horms+renesas@verge.net.au>
References: <cover.1479388193.git.horms+renesas@verge.net.au>
Message-ID: <2acb74558350b331e37d547a888212e9e0969c10.1479388193.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This updates H3ULCB Device tree bindings Documentation with
official board name

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 23c77315fdac..968ae9a05440 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -49,7 +49,7 @@ Boards:
     compatible = "renesas,genmai", "renesas,r7s72100"
   - Gose
     compatible = "renesas,gose", "renesas,r8a7793"
-  - H3ULCB (RTP0RC7795SKB00010S)
+  - H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKB00010S)
     compatible = "renesas,h3ulcb", "renesas,r8a7795";
   - Henninger
     compatible = "renesas,henninger", "renesas,r8a7791"
-- 
2.7.0.rc3.207.g0ac5344
