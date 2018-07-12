From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 12 Jul 2018 00:10:20 -0400
Subject: [PATCH v3 2/6] arm: dts: zynq: correct and improve the model property
 of dt files
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Message-ID: <20180712041024.20583-3-luaraneda@gmail.com>
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
index 1a0f631c1d8d..8b9ab9bba23b 100644
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
index 574ef2276182..6ed84fb15902 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -7,7 +7,7 @@
 /include/ "zynq-7000.dtsi"
 
 / {
-	model = "Zynq MicroZED Development Board";
+	model = "Avnet MicroZed board";
 	compatible = "avnet,zynq-microzed", "xlnx,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index c05f4b67d4c1..54592aeb92b9 100644
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
index f2330b0cb63d..3f84b94db995 100644
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
index 3ad1260ff2a1..a15908cacbcf 100644
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
index 6884f1ad66b7..0e1bfdd3421f 100644
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
index b78883cee96a..b7f65862c022 100644
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
index c3169d63600d..d2359b789eb8 100644
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
index 8bb66859d774..651913f1afa2 100644
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
index 595022487965..3a4ae51ca4da 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -7,7 +7,7 @@
 #include "zynq-7000.dtsi"
 
 / {
-	model = "Zynq Zed Development Board";
+	model = "Avnet ZedBoard board";
 	compatible = "avnet,zynq-zed", "xlnx,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 1e713dc98920..be40be9b7222 100644
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
index a6c00e7fa767..0439e9f1ea6f 100644
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
