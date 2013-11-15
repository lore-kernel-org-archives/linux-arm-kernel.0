From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Nov 2013 11:09:33 +0100
Subject: [PATCH] ARM: at91/dt: binding: add precision to AIC documentation
Message-ID: <1384510173-15901-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In response to the "undocumented compatible strings" message, here is a
patch which is adding the precision of two "chips" that should be used for
the "atmel,<chip>-aic" compatibility string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/arm/atmel-aic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/arm/atmel-aic.txt
index ad031211..2742e9c 100644
--- a/Documentation/devicetree/bindings/arm/atmel-aic.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-aic.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: Should be "atmel,<chip>-aic"
+  <chip> can be "at91rm9200" or "sama5d3"
 - interrupt-controller: Identifies the node as an interrupt controller.
 - interrupt-parent: For single AIC system, it is an empty property.
 - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
-- 
1.8.2.2
