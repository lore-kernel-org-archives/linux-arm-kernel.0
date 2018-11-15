From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 15 Nov 2018 23:29:38 +0100
Subject: [PATCH 1/3] dt-bindings: bcm: Add Raspberry Pi 3 A+
In-Reply-To: <1542320980-2842-1-git-send-email-stefan.wahren@i2se.com>
References: <1542320980-2842-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1542320980-2842-2-git-send-email-stefan.wahren@i2se.com>
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
