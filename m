From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Oct 2018 18:37:11 +0530
Subject: [PATCH 09/19] dt-bindings: PCI: keystone: Add bindings to get device
 control module
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
Message-ID: <20181015130721.5535-10-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings to get device control module which has the device id and
vendor id to be configured in the keystone PCIe controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci-keystone.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 4dd17de549a7..2030ee0dc4f9 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -19,6 +19,9 @@ pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
 	interrupt-cells: should be set to 1
 	interrupts: GIC interrupt lines connected to PCI MSI interrupt lines
 
+ti,syscon-pcie-id : phandle to the device control module required to set device
+		    id and vendor id.
+
  Example:
 	pcie_msi_intc: msi-interrupt-controller {
 			interrupt-controller;
-- 
2.17.1
