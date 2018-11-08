From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  8 Nov 2018 14:28:54 +0100
Subject: [PATCH] dt-bindings: arm: Add missing Xilinx boards
Message-ID: <21fdf3098b45ff1a47f271d4b2a5e496dd39a81c.1541683727.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing description for Ultra96, zcu104, zcu106 and zcu111.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git yaml-bindings

---
 Documentation/devicetree/bindings/arm/xilinx.yaml | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index dd227bccf015..a7c545464620 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -69,6 +69,14 @@ properties:
           - const: xlnx,zynqmp-zcu100
           - const: xlnx,zynqmp
 
+      - description: Xilinx 96boards compatible board Ultra96
+        items:
+          - const: avnet,ultra96-rev1
+          - const: avnet,ultra96
+          - const: xlnx,zynqmp-zcu100-revC
+          - const: xlnx,zynqmp-zcu100
+          - const: xlnx,zynqmp
+
       - description: Xilinx evaluation board zcu102
         items:
           - enum:
@@ -78,4 +86,28 @@ properties:
           - const: xlnx,zynqmp-zcu102
           - const: xlnx,zynqmp
 
+      - description: Xilinx evaluation board zcu104
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu104-revA
+              - xlnx,zynqmp-zcu104-rev1.0
+          - const: xlnx,zynqmp-zcu104
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu106
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu106-revA
+              - xlnx,zynqmp-zcu106-rev1.0
+          - const: xlnx,zynqmp-zcu106
+          - const: xlnx,zynqmp
+
+      - description: Xilinx evaluation board zcu111
+        items:
+          - enum:
+              - xlnx,zynqmp-zcu111-revA
+              - xlnx,zynqmp-zcu11-rev1.0
+          - const: xlnx,zynqmp-zcu111
+          - const: xlnx,zynqmp
+
 ...
-- 
1.9.1
