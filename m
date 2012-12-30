From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 10:15:02 -0600
Subject: [PATCH 1/6] ARM: dts: add device_type prop to cpu nodes on Calxeda
 platforms
In-Reply-To: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
Message-ID: <1356884107-30991-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

While device_type is considered deprecated, it is still needed for tools
like lshw to identify cpu nodes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/ecx-2000.dts |    4 ++++
 arch/arm/boot/dts/highbank.dts |    4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 46477ac..139b40c 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -32,6 +32,7 @@
 
 		cpu at 0 {
 			compatible = "arm,cortex-a15";
+			device_type = "cpu";
 			reg = <0>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
@@ -39,6 +40,7 @@
 
 		cpu at 1 {
 			compatible = "arm,cortex-a15";
+			device_type = "cpu";
 			reg = <1>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
@@ -46,6 +48,7 @@
 
 		cpu at 2 {
 			compatible = "arm,cortex-a15";
+			device_type = "cpu";
 			reg = <2>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
@@ -53,6 +56,7 @@
 
 		cpu at 3 {
 			compatible = "arm,cortex-a15";
+			device_type = "cpu";
 			reg = <3>;
 			clocks = <&a9pll>;
 			clock-names = "cpu";
diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index a9ae5d3..81e0bfa 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -32,6 +32,7 @@
 
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
@@ -40,6 +41,7 @@
 
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
@@ -48,6 +50,7 @@
 
 		cpu at 2 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <2>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
@@ -56,6 +59,7 @@
 
 		cpu at 3 {
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <3>;
 			next-level-cache = <&L2>;
 			clocks = <&a9pll>;
-- 
1.7.10.4
