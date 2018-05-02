From: michal.simek@xilinx.com (Michal Simek)
Date: Wed,  2 May 2018 13:34:06 +0200
Subject: [PATCH] arm64: zynqmp: Remove #address/#size-cells from gpio-keys
Message-ID: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dts reports incorrect usage of these properties in gpio-keys node.
Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary

The patch is removing these useless properties.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index c7f713c8e69e..eb5e8bddb610 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -44,8 +44,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw4 {
 			label = "sw4";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 5b4ffe646a9b..25dd57485323 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -41,8 +41,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw19 {
 			label = "sw19";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 668f7f26716a..259f21b0c001 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -41,8 +41,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw19 {
 			label = "sw19";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 9a9dd6a0142b..a61b3cc6f4c9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -41,8 +41,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw19 {
 			label = "sw19";
-- 
2.17.0
