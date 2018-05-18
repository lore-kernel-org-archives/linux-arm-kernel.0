From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:44 +0200
Subject: [PATCH 2/6] dt-bindings: arm: Document R-Car E3 SoC DT bindings
In-Reply-To: <cover.1526549153.git.horms+renesas@verge.net.au>
References: <cover.1526549153.git.horms+renesas@verge.net.au>
Message-ID: <6fdc4f90b4950a7df1d314bdc53e25c1c4e70dc9.1526549153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds device tree bindings documentation for Renesas R-Car
E3 (r8a77990).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 29093ba6c5d0..e1a24708a284 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -45,6 +45,8 @@ SoCs:
     compatible = "renesas,r8a77970"
   - R-Car V3H (R8A77980)
     compatible = "renesas,r8a77980"
+  - R-Car E3 (R8A77990)
+    compatible = "renesas,r8a77990"
   - R-Car D3 (R8A77995)
     compatible = "renesas,r8a77995"
 
-- 
2.11.0
