From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  2 Oct 2014 12:41:19 +0200
Subject: [PATCH] PCI: xilinx: Trivial fix in DT example
Message-ID: <4a72f98ee8564b6b040d6301e2719e37ddfea663.1412246470.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good to have it properly describe for c&p cases.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on linux-next. File should be in pci tree.
---
 Documentation/devicetree/bindings/pci/xilinx-pcie.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
index 3e2c88d97ad4..02f979a48aeb 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
@@ -58,5 +58,5 @@ Example:
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <1>;
-		}
+		};
 	};
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/af242394/attachment.sig>
