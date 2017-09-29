From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:50 +0200
Subject: [PATCH 3/8] ARM: shmobile: Document R-Car V3M SoC DT bindings
In-Reply-To: <cover.1506676368.git.horms+renesas@verge.net.au>
References: <cover.1506676368.git.horms+renesas@verge.net.au>
Message-ID: <443c1631172a7a6dc19c1657425354327858a548.1506676368.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index ae75cb3b1331..a1f06711a4dd 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -39,6 +39,8 @@ SoCs:
     compatible = "renesas,r8a7795"
   - R-Car M3-W (R8A77960)
     compatible = "renesas,r8a7796"
+  - R-Car V3M (R8A77970)
+    compatible = "renesas,r8a77970"
   - R-Car D3 (R8A77995)
     compatible = "renesas,r8a77995"
 
-- 
2.1.4
