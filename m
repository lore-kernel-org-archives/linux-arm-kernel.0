From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 28 Jun 2018 01:42:03 -0400
Subject: [RFC PATCH 3/5] arm: dts: zynq: correct and improve the model
 property of dt files
In-Reply-To: <20180628054205.17737-1-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
Message-ID: <20180628054205.17737-4-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the current value of the model property by a more accurate
description of each board (which includes the manufacturer), as some
of the boards had the same value ("Xilinx Zynq")

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-cc108.dts       | 2 +-
 arch/arm/boot/dts/zynq-microzed.dts    | 2 +-
 arch/arm/boot/dts/zynq-parallella.dts  | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts       | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts       | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts | 2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts         | 2 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts     | 2 +-
 arch/arm/boot/dts/zynq-zybo.dts        | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
index 1a0f631c1..8b9ab9bba 100644
--- a/arch/arm/boot/dts/zynq-cc108.dts
+++ b/arch/arm/boot/dts/zynq-cc108.dts
@@ -12,8 +12,8 @@
 /include/ "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx CC108 board";
 	compatible = "xlnx,zynq-cc108", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index e40f40a7f..3cc957428 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -7,7 +7,7 @@
 /include/ "zynq-7000.dtsi"
 
 / {
-	model = "Zynq MicroZED Development Board";
+	model = "Avnet MicroZed board";
 	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index c05f4b67d..54592aeb9 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -12,7 +12,7 @@
 /include/ "zynq-7000.dtsi"
 
 / {
-	model = "Adapteva Parallella Board";
+	model = "Adapteva Parallella board";
 	compatible = "adapteva,parallella", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index f2330b0cb..3f84b94db 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZC702 Development Board";
+	model = "Xilinx ZC702 board";
 	compatible = "xlnx,zynq-zc702", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 3ad1260ff..a15908cac 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZC706 Development Board";
+	model = "Xilinx ZC706 board";
 	compatible = "xlnx,zynq-zc706", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
index 6884f1ad6..0e1bfdd34 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM010 board";
 	compatible = "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
index b78883cee..b7f65862c 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM011 board";
 	compatible = "xlnx,zynq-zc770-xm011", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		i2c0 = &i2c1;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
index c3169d636..d2359b789 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm012.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM012 board";
 	compatible = "xlnx,zynq-zc770-xm012", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		i2c0 = &i2c0;
diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
index 8bb66859d..651913f1a 100644
--- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
@@ -8,8 +8,8 @@
 #include "zynq-7000.dtsi"
 
 / {
+	model = "Xilinx ZC770 XM013 board";
 	compatible = "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
-	model = "Xilinx Zynq";
 
 	aliases {
 		ethernet0 = &gem1;
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 98381cc85..bf3e26dbf 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq Zed Development Board";
+	model = "Avnet ZedBoard board";
 	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 1e713dc98..be40be9b7 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -3,7 +3,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZYBO Z7 Development Board";
+	model = "Digilent Zybo Z7 board";
 	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index a6c00e7fa..0439e9f1e 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq ZYBO Development Board";
+	model = "Digilent Zybo board";
 	compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";
 
 	aliases {
-- 
2.18.0
