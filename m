From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  4 Aug 2018 13:10:02 +0200
Subject: [PATCH 1/2] dt-bindings: bcm: Add Raspberry Pi CM3 and CM3L
In-Reply-To: <1533381003-13367-1-git-send-email-stefan.wahren@i2se.com>
References: <1533381003-13367-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1533381003-13367-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the root properties for Raspberry Pi Compute Module 3 and
Compute Module 3 Lite.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 1e3e29a..0dcc3ea 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -42,6 +42,14 @@ Raspberry Pi Compute Module
 Required root node properties:
 compatible = "raspberrypi,compute-module", "brcm,bcm2835";
 
+Raspberry Pi Compute Module 3
+Required root node properties:
+compatible = "raspberrypi,3-compute-module", "brcm,bcm2837";
+
+Raspberry Pi Compute Module 3 Lite
+Required root node properties:
+compatible = "raspberrypi,3-compute-module-lite", "brcm,bcm2837";
+
 Raspberry Pi Zero
 Required root node properties:
 compatible = "raspberrypi,model-zero", "brcm,bcm2835";
-- 
2.7.4
