From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 15 Mar 2013 08:57:38 -0500
Subject: [PATCH V2 5/8] ARM: dts: Add OMAP2 gpio bindings
In-Reply-To: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
References: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1363355861-11773-6-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpios bindings for OMAP2420 and OMAP2430 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi |   44 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index d4ce6c2..eee902f 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -29,6 +29,50 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		gpio1: gpio at 48018000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x48018000 0x200>;
+			interrupts = <29>;
+			ti,hwmods = "gpio1";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio2: gpio at 4801a000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4801a000 0x200>;
+			interrupts = <30>;
+			ti,hwmods = "gpio2";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio3: gpio at 4801c000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4801c000 0x200>;
+			interrupts = <31>;
+			ti,hwmods = "gpio3";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio4: gpio at 4801e000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4801e000 0x200>;
+			interrupts = <32>;
+			ti,hwmods = "gpio4";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
 		gpmc: gpmc at 6800a000 {
 			compatible = "ti,omap2420-gpmc";
 			reg = <0x6800a000 0x1000>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 832f184..fb74382 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -29,6 +29,61 @@
 			pinctrl-single,function-mask = <0x3f>;
 		};
 
+		gpio1: gpio at 4900c000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4900c000 0x200>;
+			interrupts = <29>;
+			ti,hwmods = "gpio1";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio2: gpio at 4900e000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x4900e000 0x200>;
+			interrupts = <30>;
+			ti,hwmods = "gpio2";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio3: gpio at 49010000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x49010000 0x200>;
+			interrupts = <31>;
+			ti,hwmods = "gpio3";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio4: gpio at 49012000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x49012000 0x200>;
+			interrupts = <32>;
+			ti,hwmods = "gpio4";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		gpio5: gpio at 480b6000 {
+			compatible = "ti,omap2-gpio";
+			reg = <0x480b6000 0x200>;
+			interrupts = <33>;
+			ti,hwmods = "gpio5";
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
 		gpmc: gpmc at 6e000000 {
 			compatible = "ti,omap2430-gpmc";
 			reg = <0x6e000000 0x1000>;
-- 
1.7.10.4
