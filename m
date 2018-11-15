From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 16 Nov 2018 00:00:02 +0100
Subject: [PATCH V2 1/3] dt-bindings: bcm: Add Raspberry Pi 3 A+
In-Reply-To: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
References: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542322805-6211-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the root properties for the Raspberry Pi 3 A+ .

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 0dcc3ea..245328f 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -30,6 +30,10 @@ Raspberry Pi 2 Model B
 Required root node properties:
 compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
 
+Raspberry Pi 3 Model A+
+Required root node properties:
+compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
+
 Raspberry Pi 3 Model B
 Required root node properties:
 compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
-- 
2.7.4
