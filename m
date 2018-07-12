From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 12 Jul 2018 00:10:22 -0400
Subject: [PATCH v3 4/6] dt-bindings: xilinx: zynq: Sort entries alphabetically
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Message-ID: <20180712041024.20583-5-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort additional compatible strings (boards) alphabetically
by their manufacturer and model number

This will help when finding a board because they
will be grouped by their manufacturer

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 Documentation/devicetree/bindings/arm/xilinx.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index 4f1759b2bea7..a8e70a794d2e 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -8,6 +8,9 @@ Required root node properties:
 
 Additional compatible strings:
 
+- Digilent Zybo Z7 board
+  "digilent,zynq-zybo-z7"
+
 - Xilinx CC108 internal board
   "xlnx,zynq-cc108"
 
@@ -17,9 +20,6 @@ Additional compatible strings:
   "xlnx,zynq-zc770-xm012"
   "xlnx,zynq-zc770-xm013"
 
-- Digilent Zybo Z7 board
-  "digilent,zynq-zybo-z7"
-
 ---------------------------------------------------------------
 
 Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
-- 
2.18.0
