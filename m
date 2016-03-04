From: eric@anholt.net (Eric Anholt)
Date: Fri,  4 Mar 2016 10:39:28 -0800
Subject: [PATCH 1/2] dt-bindings: Add root properties for Raspberry Pi 3
Message-ID: <1457116769-8567-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 11d3056..6ffe087 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -30,6 +30,10 @@ Raspberry Pi 2 Model B
 Required root node properties:
 compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
 
+Raspberry Pi 3 Model B
+Required root node properties:
+compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
+
 Raspberry Pi Compute Module
 Required root node properties:
 compatible = "raspberrypi,compute-module", "brcm,bcm2835";
-- 
2.7.0
