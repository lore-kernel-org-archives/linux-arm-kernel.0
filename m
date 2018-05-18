From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:31 +0200
Subject: [PATCH 009/102] arm64: dts: renesas: r8a7796: sort subnodes of the
 root node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <6ef5e21294dfd2edcc3e1bb547aef3333d42e86d.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort subnodes of the root node alphanumerically.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 162 +++++++++++++++----------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 556eb8e45499..78fbb4fd34bf 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -60,6 +60,72 @@
 		clock-frequency = <0>;
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <960000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
+	cluster1_opp: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+			turbo-mode;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -161,72 +227,6 @@
 		clock-frequency = <0>;
 	};
 
-	cluster0_opp: opp_table0 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <820000>;
-			clock-latency-ns = <300000>;
-		};
-		opp-1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
-			clock-latency-ns = <300000>;
-		};
-		opp-1500000000 {
-			opp-hz = /bits/ 64 <1500000000>;
-			opp-microvolt = <820000>;
-			clock-latency-ns = <300000>;
-		};
-		opp-1600000000 {
-			opp-hz = /bits/ 64 <1600000000>;
-			opp-microvolt = <900000>;
-			clock-latency-ns = <300000>;
-			turbo-mode;
-		};
-		opp-1700000000 {
-			opp-hz = /bits/ 64 <1700000000>;
-			opp-microvolt = <900000>;
-			clock-latency-ns = <300000>;
-			turbo-mode;
-		};
-		opp-1800000000 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <960000>;
-			clock-latency-ns = <300000>;
-			turbo-mode;
-		};
-	};
-
-	cluster1_opp: opp_table1 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-800000000 {
-			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <820000>;
-			clock-latency-ns = <300000>;
-		};
-		opp-1000000000 {
-			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
-			clock-latency-ns = <300000>;
-		};
-		opp-1200000000 {
-			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <820000>;
-			clock-latency-ns = <300000>;
-		};
-		opp-1300000000 {
-			opp-hz = /bits/ 64 <1300000000>;
-			opp-microvolt = <820000>;
-			clock-latency-ns = <300000>;
-			turbo-mode;
-		};
-	};
-
 	/* External PCIe clock - can be overridden by the board */
 	pcie_bus_clk: pcie_bus {
 		compatible = "fixed-clock";
@@ -234,13 +234,6 @@
 		clock-frequency = <0>;
 	};
 
-	pmu_a57 {
-		compatible = "arm,cortex-a57-pmu";
-		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&a57_0>, <&a57_1>;
-	};
-
 	pmu_a53 {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
@@ -250,6 +243,13 @@
 		interrupt-affinity = <&a53_0>, <&a53_1>, <&a53_2>, <&a53_3>;
 	};
 
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a57_0>, <&a57_1>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -2063,14 +2063,6 @@
 		};
 	};
 
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
 	thermal-zones {
 		sensor_thermal1: sensor-thermal1 {
 			polling-delay-passive = <250>;
@@ -2151,6 +2143,14 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	/* External USB clocks - can be overridden by the board */
 	usb3s0_clk: usb3s0 {
 		compatible = "fixed-clock";
-- 
2.11.0
