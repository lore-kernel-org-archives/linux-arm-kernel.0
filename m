From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Nov 2013 08:39:27 +0900
Subject: [PATCH] ARM: shmobile: r7s72100 GPIO DT nodes for GPIO RZ
Message-ID: <20131113233927.1559.99212.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a total of 13 GPIO DT device nodes for r7s72100.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r7s72100.dtsi |  131 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

--- 0001/arch/arm/boot/dts/r7s72100.dtsi
+++ work/arch/arm/boot/dts/r7s72100.dtsi	2013-11-13 22:33:56.000000000 +0900
@@ -14,6 +14,22 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		gpio0 = &p0;
+		gpio1 = &p1;
+		gpio2 = &p2;
+		gpio3 = &p3;
+		gpio4 = &p4;
+		gpio5 = &p5;
+		gpio6 = &p6;
+		gpio7 = &p7;
+		gpio8 = &p8;
+		gpio9 = &p9;
+		gpio10 = &p10;
+		gpio11 = &p11;
+		gpio12 = &jp0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -33,4 +49,119 @@
 		reg = <0xe8201000 0x1000>,
 			<0xe8202000 0x1000>;
 	};
+
+	p0: gpio at fcfe3100 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3100 0x4>, /* PSR */
+		  	  <0xfcfe3200 0x2>, /* PPR */
+			  <0xfcfe3800 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p1: gpio at fcfe3104 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3104 0x4>, /* PSR */
+		  	  <0xfcfe3204 0x2>, /* PPR */
+			  <0xfcfe3804 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p2: gpio at fcfe3108 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3108 0x4>, /* PSR */
+		  	  <0xfcfe3208 0x2>, /* PPR */
+			  <0xfcfe3808 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p3: gpio at fcfe310c {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe310c 0x4>, /* PSR */
+		  	  <0xfcfe320c 0x2>, /* PPR */
+			  <0xfcfe380c 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p4: gpio at fcfe3110 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3110 0x4>, /* PSR */
+		  	  <0xfcfe3210 0x2>, /* PPR */
+			  <0xfcfe3810 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p5: gpio at fcfe3114 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3114 0x4>, /* PSR */
+		  	  <0xfcfe3214 0x2>, /* PPR */
+			  <0xfcfe3814 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p6: gpio at fcfe3118 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3118 0x4>, /* PSR */
+		  	  <0xfcfe3218 0x2>, /* PPR */
+			  <0xfcfe3818 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p7: gpio at fcfe311c {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe311c 0x4>, /* PSR */
+		  	  <0xfcfe321c 0x2>, /* PPR */
+			  <0xfcfe381c 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p8: gpio at fcfe3120 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3120 0x4>, /* PSR */
+		  	  <0xfcfe3220 0x2>, /* PPR */
+			  <0xfcfe3820 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p9: gpio at fcfe3124 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3124 0x4>, /* PSR */
+		  	  <0xfcfe3224 0x2>, /* PPR */
+			  <0xfcfe3824 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p10: gpio at fcfe3128 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe3128 0x4>, /* PSR */
+		  	  <0xfcfe3228 0x2>, /* PPR */
+			  <0xfcfe3828 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	p11: gpio at fcfe312c {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe312c 0x4>, /* PSR */
+		  	  <0xfcfe322c 0x2>, /* PPR */
+			  <0xfcfe382c 0x4>; /* PMSR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	jp0: gpio at fcfe7b20 {
+		compatible = "renesas,gpio-r7s72100", "renesas,gpio-rz";
+		reg = <0xfcfe7b20 0x2>; /* JPPR */
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
 };
