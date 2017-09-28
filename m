From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 Sep 2017 16:14:54 -0700
Subject: [PATCH v2 02/10] dt-bindings: Add documentation for Broadcom
 Hurricane 2 SoCs
In-Reply-To: <20170928231502.27069-1-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
Message-ID: <20170928231502.27069-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the Broadcom Hurricane 2 SoCs used in
switching control planes.

Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
new file mode 100644
index 000000000000..a124c7fc4dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
@@ -0,0 +1,14 @@
+Broadcom Hurricane 2 device tree bindings
+---------------------------------------
+
+Broadcom Hurricane 2 family of SoCs are used for switching control. These SoCs
+are based on Broadcom's iProc SoC architecture and feature a single core Cortex
+A9 ARM CPUs, DDR2/DDR3 memory, PCIe GEN-2, USB 2.0 and USB 3.0, serial and NAND
+flash and a PCIe attached integrated switching engine.
+
+Boards with Hurricane SoCs shall have the following properties:
+
+Required root node property:
+
+BCM53342
+compatible = "brcm,bcm53342", "brcm,hr2";
-- 
2.14.1
