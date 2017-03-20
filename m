From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:33 +0100
Subject: [PATCH 2/2] ARM: shmobile: Document RZ/G1N SoC DT binding
In-Reply-To: <cover.1490000005.git.horms+renesas@verge.net.au>
References: <cover.1490000005.git.horms+renesas@verge.net.au>
Message-ID: <cfb9f93437eb6663ca99e85c47bb3656ccfe59c5.1490000005.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Document the RZ/G1N (r8a7744) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index b8155a209c58..170fe0562c63 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -17,6 +17,8 @@ SoCs:
     compatible = "renesas,r8a7742"
   - RZ/G1M (R8A77430)
     compatible = "renesas,r8a7743"
+  - RZ/G1N (R8A77440)
+    compatible = "renesas,r8a7744"
   - RZ/G1E (R8A77450)
     compatible = "renesas,r8a7745"
   - R-Car M1A (R8A77781)
-- 
2.7.0.rc3.207.g0ac5344
