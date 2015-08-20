From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 20 Aug 2015 13:46:29 -0400
Subject: [PATCH 1/5] dt-bindings: Create Documentation for NSP DT bindings
Message-ID: <1440092789-25693-1-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for the Broadcom Northstar Plus device tree
bindings.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
new file mode 100644
index 0000000..eae53e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
@@ -0,0 +1,34 @@
+Broadcom Northstar Plus device tree bindings
+--------------------------------------------
+
+Broadcom Northstar Plus family of SoCs are used for switching control
+and management applications as well as residential router/gateway
+applications. The SoC features dual core Cortex A9 ARM CPUs, integrating
+several peripheral interfaces including multiple Gigabit Ethernet PHYs,
+DDR3 memory, PCIE Gen-2, USB 2.0 and USB 3.0, serial and NAND flash,
+SATA and several other IO controllers.
+
+Boards with Northstar Plus SoCs shall have the following properties:
+
+Required root node property:
+
+BCM58522
+compatible = "brcm,bcm58522", "brcm,nsp";
+
+BCM58525
+compatible = "brcm,bcm58525", "brcm,nsp";
+
+BCM58535
+compatible = "brcm,bcm58535", "brcm,nsp";
+
+BCM58622
+compatible = "brcm,bcm58622", "brcm,nsp";
+
+BCM58623
+compatible = "brcm,bcm58623", "brcm,nsp";
+
+BCM58625
+compatible = "brcm,bcm58625", "brcm,nsp";
+
+BCM88312
+compatible = "brcm,bcm88312", "brcm,nsp";
-- 
1.9.1
