From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 17 May 2013 16:20:54 +0100
Subject: [RFC PATCH v4 11/18] ARM: dts: picoxcell: cpus/cpu nodes dts updates
In-Reply-To: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1368804061-4421-12-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the in-kernel dts files according to the latest cpus
and cpu bindings updates for ARM.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi | 8 ++++----
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
index f0a8c20..533919e 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x2.dtsi
@@ -18,13 +18,13 @@
 	#size-cells = <1>;
 
 	cpus {
-		#address-cells = <1>;
+		#address-cells = <0>;
 		#size-cells = <0>;
 
-		cpu at 0 {
-			compatible = "arm,1176jz-s";
+		cpu {
+			compatible = "arm,arm1176jz-s";
+			device_type = "cpu";
 			clock-frequency = <400000000>;
-			reg = <0>;
 			d-cache-line-size = <32>;
 			d-cache-size = <32768>;
 			i-cache-line-size = <32>;
diff --git a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
index daa962d..ab3e800 100644
--- a/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
+++ b/arch/arm/boot/dts/picoxcell-pc3x3.dtsi
@@ -18,13 +18,13 @@
 	#size-cells = <1>;
 
 	cpus {
-		#address-cells = <1>;
+		#address-cells = <0>;
 		#size-cells = <0>;
 
-		cpu at 0 {
-			compatible = "arm,1176jz-s";
+		cpu {
+			compatible = "arm,arm1176jz-s";
+			device_type = "cpu";
 			cpu-clock = <&arm_clk>, "cpu";
-			reg = <0>;
 			d-cache-line-size = <32>;
 			d-cache-size = <32768>;
 			i-cache-line-size = <32>;
-- 
1.8.2.2
