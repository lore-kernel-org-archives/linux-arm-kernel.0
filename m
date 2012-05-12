From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:53 -0600
Subject: [PATCH 1/9] ARM: dt: tegra: whitespace cleanup
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Consistently don't place a space after < or before >.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-cardhu.dts    |    4 +-
 arch/arm/boot/dts/tegra-harmony.dts   |    8 +-
 arch/arm/boot/dts/tegra-seaboard.dts  |   26 ++++----
 arch/arm/boot/dts/tegra-trimslice.dts |    4 +-
 arch/arm/boot/dts/tegra-ventana.dts   |    8 +-
 arch/arm/boot/dts/tegra20.dtsi        |  101 ++++++++++++++--------------
 arch/arm/boot/dts/tegra30.dtsi        |  120 ++++++++++++++++----------------
 7 files changed, 135 insertions(+), 136 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index 74d1ca4..378b65e 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -7,7 +7,7 @@
 	compatible = "nvidia,cardhu", "nvidia,tegra30";
 
 	memory {
-		reg = < 0x80000000 0x40000000 >;
+		reg = <0x80000000 0x40000000>;
 	};
 
 	pinmux at 70000000 {
@@ -64,7 +64,7 @@
 	};
 
 	serial at 70006000 {
-		clock-frequency = < 408000000 >;
+		clock-frequency = <408000000>;
 	};
 
 	serial at 70006040 {
diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
index 6857cec..04647b3 100644
--- a/arch/arm/boot/dts/tegra-harmony.dts
+++ b/arch/arm/boot/dts/tegra-harmony.dts
@@ -7,7 +7,7 @@
 	compatible = "nvidia,harmony", "nvidia,tegra20";
 
 	memory at 0 {
-		reg = < 0x00000000 0x40000000 >;
+		reg = <0x00000000 0x40000000>;
 	};
 
 	pinmux at 70000000 {
@@ -245,14 +245,14 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = < 187 0x04 >;
+			interrupts = <187 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
-			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
+			gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
 		};
 	};
 
@@ -309,7 +309,7 @@
 	};
 
 	serial at 70006300 {
-		clock-frequency = < 216000000 >;
+		clock-frequency = <216000000>;
 	};
 
 	serial at 70006400 {
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index c4d171e..d4cbd80 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -8,7 +8,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = < 0x00000000 0x40000000 >;
+		reg = <0x00000000 0x40000000>;
 	};
 
 	pinmux at 70000000 {
@@ -265,14 +265,14 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = < 187 0x04 >;
+			interrupts = <187 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
-			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
+			gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
 		};
 
 		/* ALS and proximity sensor */
@@ -280,7 +280,7 @@
 			compatible = "isil,isl29018";
 			reg = <0x44>;
 			interrupt-parent = <&gpio>;
-			interrupts = < 202 0x04 >; /* GPIO PZ2 */
+			interrupts = <202 0x04>; /* GPIO PZ2 */
 		};
 
 		gyrometer at 68 {
@@ -361,7 +361,7 @@
 	};
 
 	serial at 70006300 {
-		clock-frequency = < 216000000 >;
+		clock-frequency = <216000000>;
 	};
 
 	serial at 70006400 {
@@ -413,10 +413,10 @@
 
 	emc at 7000f400 {
 		emc-table at 190000 {
-			reg = < 190000 >;
+			reg = <190000>;
 			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = < 190000 >;
-			nvidia,emc-registers = < 0x0000000c 0x00000026
+			clock-frequency = <190000>;
+			nvidia,emc-registers = <0x0000000c 0x00000026
 				0x00000009 0x00000003 0x00000004 0x00000004
 				0x00000002 0x0000000c 0x00000003 0x00000003
 				0x00000002 0x00000001 0x00000004 0x00000005
@@ -427,14 +427,14 @@
 				0x00000002 0x00000000 0x00000000 0x00000002
 				0x00000000 0x00000000 0x00000083 0xa06204ae
 				0x007dc010 0x00000000 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000 >;
+				0x00000000 0x00000000 0x00000000 0x00000000>;
 		};
 
 		emc-table at 380000 {
-			reg = < 380000 >;
+			reg = <380000>;
 			compatible = "nvidia,tegra20-emc-table";
-			clock-frequency = < 380000 >;
-			nvidia,emc-registers = < 0x00000017 0x0000004b
+			clock-frequency = <380000>;
+			nvidia,emc-registers = <0x00000017 0x0000004b
 				0x00000012 0x00000006 0x00000004 0x00000005
 				0x00000003 0x0000000c 0x00000006 0x00000006
 				0x00000003 0x00000001 0x00000004 0x00000005
@@ -445,7 +445,7 @@
 				0x00000002 0x00000000 0x00000000 0x00000002
 				0x00000000 0x00000000 0x00000083 0xe044048b
 				0x007d8010 0x00000000 0x00000000 0x00000000
-				0x00000000 0x00000000 0x00000000 0x00000000 >;
+				0x00000000 0x00000000 0x00000000 0x00000000>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra-trimslice.dts
index ead9365..7181a5e 100644
--- a/arch/arm/boot/dts/tegra-trimslice.dts
+++ b/arch/arm/boot/dts/tegra-trimslice.dts
@@ -7,7 +7,7 @@
 	compatible = "compulab,trimslice", "nvidia,tegra20";
 
 	memory at 0 {
-		reg = < 0x00000000 0x40000000 >;
+		reg = <0x00000000 0x40000000>;
 	};
 
 	pinmux at 70000000 {
@@ -277,7 +277,7 @@
 	};
 
 	serial at 70006000 {
-		clock-frequency = < 216000000 >;
+		clock-frequency = <216000000>;
 	};
 
 	serial at 70006040 {
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index c20d5e9..9d2bc27 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -7,7 +7,7 @@
 	compatible = "nvidia,ventana", "nvidia,tegra20";
 
 	memory {
-		reg = < 0x00000000 0x40000000 >;
+		reg = <0x00000000 0x40000000>;
 	};
 
 	pinmux at 70000000 {
@@ -247,14 +247,14 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = < 187 0x04 >;
+			interrupts = <187 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
 
 			micdet-cfg = <0>;
 			micdet-delay = <100>;
-			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
+			gpio-cfg = <0xffffffff 0xffffffff 0 0xffffffff 0xffffffff>;
 		};
 
 		/* ALS and proximity sensor */
@@ -319,7 +319,7 @@
 	};
 
 	serial at 70006300 {
-		clock-frequency = < 216000000 >;
+		clock-frequency = <216000000>;
 	};
 
 	serial at 70006400 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index a76c8a8..f98be33 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -13,8 +13,8 @@
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = < 0x50041000 0x1000 >,
-		      < 0x50040100 0x0100 >;
+		reg = <0x50041000 0x1000>,
+		      <0x50040100 0x0100>;
 	};
 
 	pmu {
@@ -26,22 +26,22 @@
 	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1200>;
-		interrupts = < 0 104 0x04
-			       0 105 0x04
-			       0 106 0x04
-			       0 107 0x04
-			       0 108 0x04
-			       0 109 0x04
-			       0 110 0x04
-			       0 111 0x04
-			       0 112 0x04
-			       0 113 0x04
-			       0 114 0x04
-			       0 115 0x04
-			       0 116 0x04
-			       0 117 0x04
-			       0 118 0x04
-			       0 119 0x04 >;
+		interrupts = <0 104 0x04
+			      0 105 0x04
+			      0 106 0x04
+			      0 107 0x04
+			      0 108 0x04
+			      0 109 0x04
+			      0 110 0x04
+			      0 111 0x04
+			      0 112 0x04
+			      0 113 0x04
+			      0 114 0x04
+			      0 115 0x04
+			      0 116 0x04
+			      0 117 0x04
+			      0 118 0x04
+			      0 119 0x04>;
 	};
 
 	i2c at 7000c000 {
@@ -49,7 +49,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000C000 0x100>;
-		interrupts = < 0 38 0x04 >;
+		interrupts = <0 38 0x04>;
 	};
 
 	i2c at 7000c400 {
@@ -57,7 +57,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000C400 0x100>;
-		interrupts = < 0 84 0x04 >;
+		interrupts = <0 84 0x04>;
 	};
 
 	i2c at 7000c500 {
@@ -65,7 +65,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000C500 0x100>;
-		interrupts = < 0 92 0x04 >;
+		interrupts = <0 92 0x04>;
 	};
 
 	i2c at 7000d000 {
@@ -73,21 +73,21 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c-dvc";
 		reg = <0x7000D000 0x200>;
-		interrupts = < 0 53 0x04 >;
+		interrupts = <0 53 0x04>;
 	};
 
 	tegra_i2s1: i2s at 70002800 {
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
-		interrupts = < 0 13 0x04 >;
-		nvidia,dma-request-selector = < &apbdma 2 >;
+		interrupts = <0 13 0x04>;
+		nvidia,dma-request-selector = <&apbdma 2>;
 	};
 
 	tegra_i2s2: i2s at 70002a00 {
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002a00 0x200>;
-		interrupts = < 0 3 0x04 >;
-		nvidia,dma-request-selector = < &apbdma 1 >;
+		interrupts = <0 3 0x04>;
+		nvidia,dma-request-selector = <&apbdma 1>;
 	};
 
 	das at 70000c00 {
@@ -97,14 +97,14 @@
 
 	gpio: gpio at 6000d000 {
 		compatible = "nvidia,tegra20-gpio";
-		reg = < 0x6000d000 0x1000 >;
-		interrupts = < 0 32 0x04
-			       0 33 0x04
-			       0 34 0x04
-			       0 35 0x04
-			       0 55 0x04
-			       0 87 0x04
-			       0 89 0x04 >;
+		reg = <0x6000d000 0x1000>;
+		interrupts = <0 32 0x04
+			      0 33 0x04
+			      0 34 0x04
+			      0 35 0x04
+			      0 55 0x04
+			      0 87 0x04
+			      0 89 0x04>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		#interrupt-cells = <2>;
@@ -113,45 +113,45 @@
 
 	pinmux: pinmux at 70000000 {
 		compatible = "nvidia,tegra20-pinmux";
-		reg = < 0x70000014 0x10    /* Tri-state registers */
-			0x70000080 0x20    /* Mux registers */
-			0x700000a0 0x14    /* Pull-up/down registers */
-			0x70000868 0xa8 >; /* Pad control registers */
+		reg = <0x70000014 0x10   /* Tri-state registers */
+		       0x70000080 0x20   /* Mux registers */
+		       0x700000a0 0x14   /* Pull-up/down registers */
+		       0x70000868 0xa8>; /* Pad control registers */
 	};
 
 	serial at 70006000 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
-		interrupts = < 0 36 0x04 >;
+		interrupts = <0 36 0x04>;
 	};
 
 	serial at 70006040 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
-		interrupts = < 0 37 0x04 >;
+		interrupts = <0 37 0x04>;
 	};
 
 	serial at 70006200 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
-		interrupts = < 0 46 0x04 >;
+		interrupts = <0 46 0x04>;
 	};
 
 	serial at 70006300 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
-		interrupts = < 0 90 0x04 >;
+		interrupts = <0 90 0x04>;
 	};
 
 	serial at 70006400 {
 		compatible = "nvidia,tegra20-uart";
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
-		interrupts = < 0 91 0x04 >;
+		interrupts = <0 91 0x04>;
 	};
 
 	emc at 7000f400 {
@@ -164,31 +164,31 @@
 	sdhci at c8000000 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000000 0x200>;
-		interrupts = < 0 14 0x04 >;
+		interrupts = <0 14 0x04>;
 	};
 
 	sdhci at c8000200 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000200 0x200>;
-		interrupts = < 0 15 0x04 >;
+		interrupts = <0 15 0x04>;
 	};
 
 	sdhci at c8000400 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000400 0x200>;
-		interrupts = < 0 19 0x04 >;
+		interrupts = <0 19 0x04>;
 	};
 
 	sdhci at c8000600 {
 		compatible = "nvidia,tegra20-sdhci";
 		reg = <0xc8000600 0x200>;
-		interrupts = < 0 31 0x04 >;
+		interrupts = <0 31 0x04>;
 	};
 
 	usb at c5000000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5000000 0x4000>;
-		interrupts = < 0 20 0x04 >;
+		interrupts = <0 20 0x04>;
 		phy_type = "utmi";
 		nvidia,has-legacy-mode;
 	};
@@ -196,14 +196,14 @@
 	usb at c5004000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5004000 0x4000>;
-		interrupts = < 0 21 0x04 >;
+		interrupts = <0 21 0x04>;
 		phy_type = "ulpi";
 	};
 
 	usb at c5008000 {
 		compatible = "nvidia,tegra20-ehci", "usb-ehci";
 		reg = <0xc5008000 0x4000>;
-		interrupts = < 0 97 0x04 >;
+		interrupts = <0 97 0x04>;
 		phy_type = "utmi";
 	};
 
@@ -225,4 +225,3 @@
 		       0x58000000 0x02000000>;	/* GART aperture */
 	};
 };
-
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index e9792ac..5dd6556 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -13,8 +13,8 @@
 		compatible = "arm,cortex-a9-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = < 0x50041000 0x1000 >,
-		      < 0x50040100 0x0100 >;
+		reg = <0x50041000 0x1000>,
+		      <0x50040100 0x0100>;
 	};
 
 	pmu {
@@ -28,38 +28,38 @@
 	apbdma: dma at 6000a000 {
 		compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
 		reg = <0x6000a000 0x1400>;
-		interrupts = < 0 104 0x04
-			       0 105 0x04
-			       0 106 0x04
-			       0 107 0x04
-			       0 108 0x04
-			       0 109 0x04
-			       0 110 0x04
-			       0 111 0x04
-			       0 112 0x04
-			       0 113 0x04
-			       0 114 0x04
-			       0 115 0x04
-			       0 116 0x04
-			       0 117 0x04
-			       0 118 0x04
-			       0 119 0x04
-			       0 128 0x04
-			       0 129 0x04
-			       0 130 0x04
-			       0 131 0x04
-			       0 132 0x04
-			       0 133 0x04
-			       0 134 0x04
-			       0 135 0x04
-			       0 136 0x04
-			       0 137 0x04
-			       0 138 0x04
-			       0 139 0x04
-			       0 140 0x04
-			       0 141 0x04
-			       0 142 0x04
-			       0 143 0x04 >;
+		interrupts = <0 104 0x04
+			      0 105 0x04
+			      0 106 0x04
+			      0 107 0x04
+			      0 108 0x04
+			      0 109 0x04
+			      0 110 0x04
+			      0 111 0x04
+			      0 112 0x04
+			      0 113 0x04
+			      0 114 0x04
+			      0 115 0x04
+			      0 116 0x04
+			      0 117 0x04
+			      0 118 0x04
+			      0 119 0x04
+			      0 128 0x04
+			      0 129 0x04
+			      0 130 0x04
+			      0 131 0x04
+			      0 132 0x04
+			      0 133 0x04
+			      0 134 0x04
+			      0 135 0x04
+			      0 136 0x04
+			      0 137 0x04
+			      0 138 0x04
+			      0 139 0x04
+			      0 140 0x04
+			      0 141 0x04
+			      0 142 0x04
+			      0 143 0x04>;
 	};
 
 	i2c at 7000c000 {
@@ -67,7 +67,7 @@
 		#size-cells = <0>;
 		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000C000 0x100>;
-		interrupts = < 0 38 0x04 >;
+		interrupts = <0 38 0x04>;
 	};
 
 	i2c at 7000c400 {
@@ -75,7 +75,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000C400 0x100>;
-		interrupts = < 0 84 0x04 >;
+		interrupts = <0 84 0x04>;
 	};
 
 	i2c at 7000c500 {
@@ -83,7 +83,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000C500 0x100>;
-		interrupts = < 0 92 0x04 >;
+		interrupts = <0 92 0x04>;
 	};
 
 	i2c at 7000c700 {
@@ -91,7 +91,7 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c700 0x100>;
-		interrupts = < 0 120 0x04 >;
+		interrupts = <0 120 0x04>;
 	};
 
 	i2c at 7000d000 {
@@ -99,20 +99,20 @@
 		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000D000 0x100>;
-		interrupts = < 0 53 0x04 >;
+		interrupts = <0 53 0x04>;
 	};
 
 	gpio: gpio at 6000d000 {
 		compatible = "nvidia,tegra30-gpio", "nvidia,tegra20-gpio";
-		reg = < 0x6000d000 0x1000 >;
-		interrupts = < 0 32 0x04
-			       0 33 0x04
-			       0 34 0x04
-			       0 35 0x04
-			       0 55 0x04
-			       0 87 0x04
-			       0 89 0x04
-			       0 125 0x04 >;
+		reg = <0x6000d000 0x1000>;
+		interrupts = <0 32 0x04
+			      0 33 0x04
+			      0 34 0x04
+			      0 35 0x04
+			      0 55 0x04
+			      0 87 0x04
+			      0 89 0x04
+			      0 125 0x04>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		#interrupt-cells = <2>;
@@ -123,71 +123,71 @@
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
-		interrupts = < 0 36 0x04 >;
+		interrupts = <0 36 0x04>;
 	};
 
 	serial at 70006040 {
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
-		interrupts = < 0 37 0x04 >;
+		interrupts = <0 37 0x04>;
 	};
 
 	serial at 70006200 {
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
-		interrupts = < 0 46 0x04 >;
+		interrupts = <0 46 0x04>;
 	};
 
 	serial at 70006300 {
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
-		interrupts = < 0 90 0x04 >;
+		interrupts = <0 90 0x04>;
 	};
 
 	serial at 70006400 {
 		compatible = "nvidia,tegra30-uart", "nvidia,tegra20-uart";
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
-		interrupts = < 0 91 0x04 >;
+		interrupts = <0 91 0x04>;
 	};
 
 	sdhci at 78000000 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000000 0x200>;
-		interrupts = < 0 14 0x04 >;
+		interrupts = <0 14 0x04>;
 	};
 
 	sdhci at 78000200 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000200 0x200>;
-		interrupts = < 0 15 0x04 >;
+		interrupts = <0 15 0x04>;
 	};
 
 	sdhci at 78000400 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000400 0x200>;
-		interrupts = < 0 19 0x04 >;
+		interrupts = <0 19 0x04>;
 	};
 
 	sdhci at 78000600 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000600 0x200>;
-		interrupts = < 0 31 0x04 >;
+		interrupts = <0 31 0x04>;
 	};
 
 	pinmux: pinmux at 70000000 {
 		compatible = "nvidia,tegra30-pinmux";
-		reg = < 0x70000868 0xd0     /* Pad control registers */
-			0x70003000 0x3e0 >; /* Mux registers */
+		reg = <0x70000868 0xd0    /* Pad control registers */
+		       0x70003000 0x3e0>; /* Mux registers */
 	};
 
 	ahub {
 		compatible = "nvidia,tegra30-ahub";
 		reg = <0x70080000 0x200 0x70080200 0x100>;
-		interrupts = < 0 103 0x04 >;
+		interrupts = <0 103 0x04>;
 		nvidia,dma-request-selector = <&apbdma 1>;
 
 		ranges;
-- 
1.7.0.4
