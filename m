From: eric@anholt.net (Eric Anholt)
Date: Tue, 21 Apr 2015 11:09:48 -0700
Subject: [PATCH 1/9] dt-bindings: Add root properties for Raspberry Pi 2.
In-Reply-To: <1429639796-2169-1-git-send-email-eric@anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
Message-ID: <1429639796-2169-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/arm/bcm2836.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm2836.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm2836.txt b/Documentation/devicetree/bindings/arm/bcm2836.txt
new file mode 100644
index 0000000..5e255ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm2836.txt
@@ -0,0 +1,10 @@
+Broadcom BCM2836 device tree bindings
+-------------------------------------------
+
+Raspberry Pi 2 Model B
+Required root node properties:
+compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
+
+Generic BCM2836 board
+Required root node properties:
+compatible = "brcm,bcm2836";
-- 
2.1.4
