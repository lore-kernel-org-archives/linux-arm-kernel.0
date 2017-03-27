From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 27 Mar 2017 15:15:10 +0530
Subject: [PATCH v5 14/24] dt-bindings: mfd: syscon: Add documentation for
 #syscon-cells property
In-Reply-To: <20170327094520.3129-1-kishon@ti.com>
References: <20170327094520.3129-1-kishon@ti.com>
Message-ID: <20170327094520.3129-15-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the optional #syscon-cells property to determine
the number of cells that should be given in the phandle while
referencing the syscon-node.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/mfd/syscon.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
index 408f768686f1..446b47e8fb71 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.txt
+++ b/Documentation/devicetree/bindings/mfd/syscon.txt
@@ -16,6 +16,8 @@ Required properties:
 Optional property:
 - reg-io-width: the size (in bytes) of the IO accesses that should be
   performed on the device.
+- #syscon-cells: determine the number of cells that should be given in the
+  phandle while referencing this syscon-node.
 
 Examples:
 gpr: iomuxc-gpr at 020e0000 {
-- 
2.11.0
