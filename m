From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:32 +0100
Subject: [PATCH 1/2] ARM: shmobile: Document RZ/G1H SoC DT binding
In-Reply-To: <cover.1490000005.git.horms+renesas@verge.net.au>
References: <cover.1490000005.git.horms+renesas@verge.net.au>
Message-ID: <368d03531f39ffaa793a98b9a17c79d660b1cd1a.1490000005.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Document the RZ/G1H (r8a7742) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index c9502634316d..b8155a209c58 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -13,6 +13,8 @@ SoCs:
     compatible = "renesas,r8a73a4"
   - R-Mobile A1 (R8A77400)
     compatible = "renesas,r8a7740"
+  - RZ/G1H (R8A77420)
+    compatible = "renesas,r8a7742"
   - RZ/G1M (R8A77430)
     compatible = "renesas,r8a7743"
   - RZ/G1E (R8A77450)
-- 
2.7.0.rc3.207.g0ac5344
