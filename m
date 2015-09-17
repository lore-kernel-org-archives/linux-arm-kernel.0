From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:26 +0900
Subject: [PATCH 10/21] ARM: shmobile: remove paragraph on DT reference
 platforms
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <c2c7375ba2dfcce3dfc9ecf4b3e44b975fb139fc.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

They have all been eliminated now.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index eed7eb78a22e..2b9cb62838f2 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -55,7 +55,3 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
-
-Note: Reference Device Tree Implementations are temporary implementations
-      to ease the migration from platform devices to Device Tree, and are
-      intended to be removed in the future.
-- 
2.1.4
