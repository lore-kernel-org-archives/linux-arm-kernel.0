From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 13 Apr 2018 19:27:52 +0200
Subject: [PATCH 3/9] dt-bindings: bcm: Add Raspberry Pi 3 B+
In-Reply-To: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
References: <1523640478-4448-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1523640478-4448-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the root properties for the Raspberry Pi 3 B+

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 3e3efa0..1e3e29a 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -34,6 +34,10 @@ Raspberry Pi 3 Model B
 Required root node properties:
 compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
 
+Raspberry Pi 3 Model B+
+Required root node properties:
+compatible = "raspberrypi,3-model-b-plus", "brcm,bcm2837";
+
 Raspberry Pi Compute Module
 Required root node properties:
 compatible = "raspberrypi,compute-module", "brcm,bcm2835";
-- 
2.7.4
