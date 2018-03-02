From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  2 Mar 2018 20:04:27 +0100
Subject: [PATCH v3 1/8] dt-bindings: xilinx: Add description for ZynqMP
In-Reply-To: <cover.1520017397.git.michal.simek@xilinx.com>
References: <cover.1520017397.git.michal.simek@xilinx.com>
Message-ID: <c6297bd755cd2eb5eea576c05ba2c9e68e7943d7.1520017397.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Record xlnx,zynqmp compatible string.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3: None
Changes in v2:
- New patch in this series

 Documentation/devicetree/bindings/arm/xilinx.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 1f7995357888..549e70a022cb 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -5,3 +5,13 @@ shall have the following properties.
 
 Required root node properties:
     - compatible = "xlnx,zynq-7000";
+
+---------------------------------------------------------------
+
+Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
+
+Boards with ZynqMP SOC based on an ARM Cortex A53 processor
+shall have the following properties.
+
+Required root node properties:
+    - compatible = "xlnx,zynqmp";
-- 
1.9.1
