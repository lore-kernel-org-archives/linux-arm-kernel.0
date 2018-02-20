From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 20 Feb 2018 16:12:08 +0100
Subject: [PATCH v2 06/19] dt-bindings: arm: Document R-Car M3-N SoC DT bindings
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1519139541-18783-7-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings documentation for Renesas R-Car M3-N (r8a77965)
SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 41d3920..67889a9 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -39,6 +39,8 @@ SoCs:
     compatible = "renesas,r8a7795"
   - R-Car M3-W (R8A77960)
     compatible = "renesas,r8a7796"
+  - R-Car M3-N (R8A77965)
+    compatible = "renesas,r8a77965"
   - R-Car V3M (R8A77970)
     compatible = "renesas,r8a77970"
   - R-Car V3H (R8A77980)
-- 
2.7.4
