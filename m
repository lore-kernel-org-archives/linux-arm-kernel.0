From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 30 Jul 2017 19:10:33 +0200
Subject: [PATCH V2 2/3] dt-bindings: bcm: Add Raspberry Pi Zero W
In-Reply-To: <1501434634-2325-1-git-send-email-stefan.wahren@i2se.com>
References: <1501434634-2325-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1501434634-2325-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the root properties for the Raspberry Pi Zero W.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 9c97de2..3e3efa0 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -42,6 +42,10 @@ Raspberry Pi Zero
 Required root node properties:
 compatible = "raspberrypi,model-zero", "brcm,bcm2835";
 
+Raspberry Pi Zero W
+Required root node properties:
+compatible = "raspberrypi,model-zero-w", "brcm,bcm2835";
+
 Generic BCM2835 board
 Required root node properties:
 compatible = "brcm,bcm2835";
-- 
2.7.4
