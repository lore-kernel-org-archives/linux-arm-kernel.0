From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 Aug 2016 15:10:02 +0000
Subject: [PATCH V3 4/5] DT: bindings: bcm: Add Raspberry Pi Zero
In-Reply-To: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
References: <1471792204-21908-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1471792204-21908-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 6ffe087..9c97de2 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -38,6 +38,10 @@ Raspberry Pi Compute Module
 Required root node properties:
 compatible = "raspberrypi,compute-module", "brcm,bcm2835";
 
+Raspberry Pi Zero
+Required root node properties:
+compatible = "raspberrypi,model-zero", "brcm,bcm2835";
+
 Generic BCM2835 board
 Required root node properties:
 compatible = "brcm,bcm2835";
-- 
1.7.9.5
