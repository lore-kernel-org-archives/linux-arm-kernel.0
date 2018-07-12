From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 12 Jul 2018 00:10:23 -0400
Subject: [PATCH v3 5/6] dt-bindings: Move Paralella board to Xilinx
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Message-ID: <20180712041024.20583-6-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the Adapteva Parallela board to Xilinx dt-bindings,
as it's based on a Zynq SoC from Xilinx

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 Documentation/devicetree/bindings/arm/adapteva.txt | 7 -------
 Documentation/devicetree/bindings/arm/xilinx.txt   | 3 +++
 2 files changed, 3 insertions(+), 7 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt

diff --git a/Documentation/devicetree/bindings/arm/adapteva.txt b/Documentation/devicetree/bindings/arm/adapteva.txt
deleted file mode 100644
index 1d8af9e36065..000000000000
--- a/Documentation/devicetree/bindings/arm/adapteva.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Adapteva Platforms Device Tree Bindings
----------------------------------------
-
-Parallella board
-
-Required root node properties:
-    - compatible = "adapteva,parallella";
diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index a8e70a794d2e..d1a6deac90b5 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -8,6 +8,9 @@ Required root node properties:
 
 Additional compatible strings:
 
+- Adapteva Parallella board
+  "adapteva,parallella"
+
 - Digilent Zybo Z7 board
   "digilent,zynq-zybo-z7"
 
-- 
2.18.0
