From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 12 Jan 2017 15:56:19 +0530
Subject: [PATCH 30/37] dt-bindings: PCI: dra7xx: Add dt bindings to enable
 legacy mode
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
Message-ID: <1484216786-17292-31-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update device tree binding documentation of TI's dra7xx PCI
controller to include property for enabling legacy mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 62f5f59..ed85e8e 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -39,6 +39,10 @@ DEVICE MODE
  - interrupts : one interrupt entries must be specified for main interrupt.
  - num-ib-windows : number of inbound address translation windows
  - num-ob-windows : number of outbound address translation windows
+ - syscon-legacy-mode: phandle to the syscon dt node. The 1st argument should
+		       contain the register offset within syscon and the 2nd
+		       argument should contain the bit field for setting the
+		       legacy mode
 
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
-- 
1.7.9.5
