From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 Dec 2015 15:55:10 -0800
Subject: [PATCH v2 3/8] dt-bindings: Add root properties for Raspberry Pi 2
In-Reply-To: <1450310115-22163-1-git-send-email-eric@anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
Message-ID: <1450310115-22163-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index c78576b..11d3056 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -26,6 +26,10 @@ Raspberry Pi Model B+
 Required root node properties:
 compatible = "raspberrypi,model-b-plus", "brcm,bcm2835";
 
+Raspberry Pi 2 Model B
+Required root node properties:
+compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
+
 Raspberry Pi Compute Module
 Required root node properties:
 compatible = "raspberrypi,compute-module", "brcm,bcm2835";
-- 
2.6.2
