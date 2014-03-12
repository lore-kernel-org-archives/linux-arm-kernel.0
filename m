From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 12 Mar 2014 20:46:33 +0530
Subject: [PATCH v5 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
References: <1394637394-3960-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1394637394-3960-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds the dts files for exynos5260.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi |  574 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5260.dtsi         |  400 ++++++++++++++++++++
 2 files changed, 974 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5260.dtsi

diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
new file mode 100644
index 0000000..f6ee55e
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -0,0 +1,574 @@
+/*
+ * Samsung's Exynos5260 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos5260 SoC pin-mux and pin-config options are listed as device
+ * tree nodes are listed in this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define PIN_PULL_NONE	0
+#define PIN_PULL_DOWN	1
+#define PIN_PULL_UP	3
+
+&pinctrl_0 {
+	gpa0: gpa0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpa1: gpa1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpa2: gpa2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb0: gpb0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb1: gpb1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb2: gpb2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb3: gpb3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb4: gpb4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb5: gpb5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd0: gpd0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd1: gpd1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd2: gpd2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpe0: gpe0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpe1: gpe1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf0: gpf0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf1: gpf1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpk0: gpk0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpx0: gpx0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpx1: gpx1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpx2: gpx2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpx3: gpx3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	uart0_data: uart0-data {
+		samsung,pins = "gpa0-0", "gpa0-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart0_fctl: uart0-fctl {
+		samsung,pins = "gpa0-2", "gpa0-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart1_data: uart1-data {
+		samsung,pins = "gpa1-0", "gpa1-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart1_fctl: uart1-fctl {
+		samsung,pins = "gpa1-2", "gpa1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart2_data: uart2-data {
+		samsung,pins = "gpa1-4", "gpa1-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi0_bus: spi0-bus {
+		samsung,pins = "gpa2-0", "gpa2-2", "gpa2-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi1_bus: spi1-bus {
+		samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	usb3_vbus0_en: usb3-vbus0-en {
+		samsung,pins = "gpa2-4";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2s1_bus: i2s1-bus {
+		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+				"gpb0-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	pcm1_bus: pcm1-bus {
+		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+				"gpb0-4";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	spdif1_bus: spdif1-bus {
+		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi2_bus: spi2-bus {
+		samsung,pins = "gpb1-0", "gpb1-2", "gpb1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c0_hs_bus: i2c0-hs-bus {
+		samsung,pins = "gpb3-0", "gpb3-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c1_hs_bus: i2c1-hs-bus {
+		samsung,pins = "gpb3-2", "gpb3-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c2_hs_bus: i2c2-hs-bus {
+		samsung,pins = "gpb3-4", "gpb3-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c3_hs_bus: i2c3-hs-bus {
+		samsung,pins = "gpb3-6", "gpb3-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c4_bus: i2c4-bus {
+		samsung,pins = "gpb4-0", "gpb4-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c5_bus: i2c5-bus {
+		samsung,pins = "gpb4-2", "gpb4-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c6_bus: i2c6-bus {
+		samsung,pins = "gpb4-4", "gpb4-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c7_bus: i2c7-bus {
+		samsung,pins = "gpb4-6", "gpb4-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c8_bus: i2c8-bus {
+		samsung,pins = "gpb5-0", "gpb5-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c9_bus: i2c9-bus {
+		samsung,pins = "gpb5-2", "gpb5-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c10_bus: i2c10-bus {
+		samsung,pins = "gpb5-4", "gpb5-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2c11_bus: i2c11-bus {
+		samsung,pins = "gpb5-6", "gpb5-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	cam_gpio_a: cam-gpio-a {
+		samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
+			"gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
+			"gpe1-0", "gpe1-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	cam_gpio_b: cam-gpio-b {
+		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3",
+			"gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	cam_i2c1_bus: cam-i2c1-bus {
+		samsung,pins = "gpf0-2", "gpf0-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	cam_i2c0_bus: cam-i2c0-bus {
+		samsung,pins = "gpf0-0", "gpf0-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <0>;
+	};
+
+	cam_spi0_bus: cam-spi0-bus {
+		samsung,pins = "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+
+	cam_spi1_bus: cam-spi1-bus {
+		samsung,pins = "gpf1-4", "gpf1-5", "gpf1-6", "gpf1-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_1 {
+	gpc0: gpc0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc1: gpc1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc2: gpc2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc3: gpc3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc4: gpc4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sd0_clk: sd0-clk {
+		samsung,pins = "gpc0-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_cmd: sd0-cmd {
+		samsung,pins = "gpc0-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus1: sd0-bus-width1 {
+		samsung,pins = "gpc0-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus4: sd0-bus-width4 {
+		samsung,pins = "gpc0-3", "gpc0-4", "gpc0-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus8: sd0-bus-width8 {
+		samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_rdqs: sd0-rdqs {
+		samsung,pins = "gpc0-6";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_clk: sd1-clk {
+		samsung,pins = "gpc1-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_cmd: sd1-cmd {
+		samsung,pins = "gpc1-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_bus1: sd1-bus-width1 {
+		samsung,pins = "gpc1-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_bus4: sd1-bus-width4 {
+		samsung,pins = "gpc1-3", "gpc1-4", "gpc1-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_bus8: sd1-bus-width8 {
+		samsung,pins = "gpc4-0", "gpc4-1", "gpc4-2", "gpc4-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_clk: sd2-clk {
+		samsung,pins = "gpc2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cmd: sd2-cmd {
+		samsung,pins = "gpc2-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_NONE>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cd: sd2-cd {
+		samsung,pins = "gpc2-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus1: sd2-bus-width1 {
+		samsung,pins = "gpc2-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus4: sd2-bus-width4 {
+		samsung,pins = "gpc2-4", "gpc2-5", "gpc2-6";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+		samsung,pin-drv = <3>;
+	};
+};
+
+&pinctrl_2 {
+	gpz0: gpz0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpz1: gpz1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
new file mode 100644
index 0000000..a99ef77
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -0,0 +1,400 @@
+/*
+ * SAMSUNG EXYNOS5260 SoC device tree source
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include "skeleton.dtsi"
+
+#include <dt-bindings/clock/exynos5260-clk.h>
+
+/ {
+	compatible = "samsung,exynos5260";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		pinctrl0 = &pinctrl_0;
+		pinctrl1 = &pinctrl_1;
+		pinctrl2 = &pinctrl_2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			cci-control-port = <&cci_control1>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			cci-control-port = <&cci_control1>;
+		};
+
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			cci-control-port = <&cci_control0>;
+		};
+
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			cci-control-port = <&cci_control0>;
+		};
+
+		cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			cci-control-port = <&cci_control0>;
+		};
+
+		cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			cci-control-port = <&cci_control0>;
+		};
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clock_top: clock-controller at 10010000 {
+			compatible = "samsung,exynos5260-clock-top";
+			reg = <0x10010000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_peri: clock-controller at 10200000 {
+			compatible = "samsung,exynos5260-clock-peri";
+			reg = <0x10200000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_egl: clock-controller at 10600000 {
+			compatible = "samsung,exynos5260-clock-egl";
+			reg = <0x10600000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_kfc: clock-controller at 10700000 {
+			compatible = "samsung,exynos5260-clock-kfc";
+			reg = <0x10700000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_g2d: clock-controller at 10A00000 {
+			compatible = "samsung,exynos5260-clock-g2d";
+			reg = <0x10A00000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_mif: clock-controller at 10CE0000 {
+			compatible = "samsung,exynos5260-clock-mif";
+			reg = <0x10CE0000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_mfc: clock-controller at 11090000 {
+			compatible = "samsung,exynos5260-clock-mfc";
+			reg = <0x11090000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_g3d: clock-controller at 11830000 {
+			compatible = "samsung,exynos5260-clock-g3d";
+			reg = <0x11830000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_fsys: clock-controller at 122E0000 {
+			compatible = "samsung,exynos5260-clock-fsys";
+			reg = <0x122E0000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_aud: clock-controller at 128C0000 {
+			compatible = "samsung,exynos5260-clock-aud";
+			reg = <0x128C0000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_isp: clock-controller at 133C0000 {
+			compatible = "samsung,exynos5260-clock-isp";
+			reg = <0x133C0000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_gscl: clock-controller at 13F00000 {
+			compatible = "samsung,exynos5260-clock-gscl";
+			reg = <0x13F00000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_disp: clock-controller at 14550000 {
+			compatible = "samsung,exynos5260-clock-disp";
+			reg = <0x14550000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clocks {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dptx_phy_ch0: phyclk_dptx_phy_ch0_txd {
+				compatible = "fixed-clock";
+				clock-frequency = <270000000>;
+				clock-output-names = "phyclk_dptx_phy_ch0_txd_clk";
+			};
+
+			dptx_phy_ch1: phyclk_dptx_phy_ch1_txd {
+				compatible = "fixed-clock";
+				clock-frequency = <270000000>;
+				clock-output-names = "phyclk_dptx_phy_ch1_txd_clk";
+			};
+
+			dptx_phy_ch2: phyclk_dptx_phy_ch2_txd {
+				compatible = "fixed-clock";
+				clock-frequency = <270000000>;
+				clock-output-names = "phyclk_dptx_phy_ch2_txd_clk";
+			};
+
+			dptx_phy_ch3: phyclk_dptx_phy_ch3_txd_clk {
+				compatible = "fixed-clock";
+				clock-frequency = <270000000>;
+				clock-output-names = "phyclk_dptx_phy_ch3_txd_clk";
+			};
+
+			hdmiphy_tmds_clko: phyclk_hdmi_phy_tmds_clko {
+				compatible = "fixed-clock";
+				clock-frequency = <250000000>;
+				clock-output-names = "phyclk_hdmi_phy_tmds_clko";
+			};
+
+			hdmiphy_pixel_clko: phyclk_hdmi_phy_pixel_clko {
+				compatible = "fixed-clock";
+				clock-frequency = <166000000>;
+				clock-output-names = "phyclk_hdmi_phy_pixel_clko";
+			};
+
+			hdmi_link_tmds_clkhi: phyclk_hdmi_link_o_tmds_clkhi {
+				compatible = "fixed-clock";
+				clock-frequency = <125000000>;
+				clock-output-names = "phyclk_hdmi_link_o_tmds_clkhi";
+			};
+
+			dptx_phy_ref_clk: phyclk_dptx_phy_o_ref_clk_24m {
+				compatible = "fixed-clock";
+				clock-frequency = <24000000>;
+				clock-output-names = "phyclk_dptx_phy_o_ref_clk_24m";
+			};
+
+			dptx_phy_clk_div2: phyclk_dptx_phy_clk_div2 {
+				compatible = "fixed-clock";
+				clock-frequency = <135000000>;
+				clock-output-names = "phyclk_dptx_phy_clk_div2";
+			};
+
+			mipi_dphy_rxclkesc0: phyclk_mipi_dphy_4l_m_rxclkesc0 {
+				compatible = "fixed-clock";
+				clock-frequency = <20000000>;
+				clock-output-names = "phyclk_mipi_dphy_4l_m_rxclkesc0";
+			};
+
+			usbhost20_phy_phyclock: phyclk_usbhost20_phy_phyclock {
+				compatible = "fixed-clock";
+				clock-frequency = <60000000>;
+				clock-output-names = "phyclk_usbhost20_phy_phyclock";
+			};
+
+			usbhost20_phy_freeclk: phyclk_usbhost20_phy_freeclk {
+				compatible = "fixed-clock";
+				clock-frequency = <60000000>;
+				clock-output-names = "phyclk_usbhost20_phy_freeclk";
+			};
+
+			usbhost20_phy_clk48mohci: phyclk_usbhost20_phy_clk48mohci {
+				compatible = "fixed-clock";
+				clock-frequency = <48000000>;
+				clock-output-names = "phyclk_usbhost20_phy_clk48mohci";
+			};
+
+			usbdrd30_pipe_pclk: phyclk_usbdrd30_udrd30_pipe_pclk {
+				compatible = "fixed-clock";
+				clock-frequency = <125000000>;
+				clock-output-names = "phyclk_usbdrd30_udrd30_pipe_pclk";
+			};
+
+			usbdrd30_phyclock: phyclk_usbdrd30_udrd30_phyclock {
+				compatible = "fixed-clock";
+				clock-frequency = <60000000>;
+				clock-output-names = "phyclk_usbdrd30_udrd30_phyclock";
+			};
+		};
+
+		gic: interrupt-controller at 10481000 {
+			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-controller;
+			reg = <0x10481000 0x1000>,
+				<0x10482000 0x1000>,
+				<0x10484000 0x2000>,
+				<0x10486000 0x2000>;
+			interrupts = <1 9 0xf04>;
+		};
+
+		chipid: chipid at 10000000 {
+			compatible = "samsung,exynos4210-chipid";
+			reg = <0x10000000 0x100>;
+		};
+
+		mct: mct at 100B0000 {
+			compatible = "samsung,exynos4210-mct";
+			reg = <0x100B0000 0x1000>;
+			clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
+			clock-names = "fin_pll", "mct";
+			interrupts = <0 104 0>, <0 105 0>, <0 106 0>,
+					<0 107 0>, <0 122 0>, <0 123 0>,
+					<0 124 0>, <0 125 0>, <0 126 0>,
+					<0 127 0>, <0 128 0>, <0 129 0>;
+		};
+
+		cci: cci at 10F00000 {
+			compatible = "arm,cci-400";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x10F00000 0x1000>;
+			ranges = <0x0 0x10F00000 0x6000>;
+
+			cci_control0: slave-if at 4000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x4000 0x1000>;
+			};
+
+			cci_control1: slave-if at 5000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x5000 0x1000>;
+			};
+		};
+
+		pinctrl_0: pinctrl at 11600000 {
+			compatible = "samsung,exynos5260-pinctrl";
+			reg = <0x11600000 0x1000>;
+			interrupts = <0 79 0>;
+
+			wakeup-interrupt-controller {
+				compatible = "samsung,exynos4210-wakeup-eint";
+				interrupt-parent = <&gic>;
+				interrupts = <0 32 0>;
+			};
+		};
+
+		pinctrl_1: pinctrl at 12290000 {
+			compatible = "samsung,exynos5260-pinctrl";
+			reg = <0x12290000 0x1000>;
+			interrupts = <0 157 0>;
+		};
+
+		pinctrl_2: pinctrl at 128B0000 {
+			compatible = "samsung,exynos5260-pinctrl";
+			reg = <0x128B0000 0x1000>;
+			interrupts = <0 243 0>;
+		};
+
+		uart0: serial at 12C00000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x12C00000 0x100>;
+			interrupts = <0 146 0>;
+			clocks = <&clock_peri PERI_CLK_UART0>, <&clock_peri PERI_SCLK_UART0>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		uart1: serial at 12C10000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x12C10000 0x100>;
+			interrupts = <0 147 0>;
+			clocks = <&clock_peri PERI_CLK_UART1>, <&clock_peri PERI_SCLK_UART1>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		uart2: serial at 12C20000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x12C20000 0x100>;
+			interrupts = <0 148 0>;
+			clocks = <&clock_peri PERI_CLK_UART2>, <&clock_peri PERI_SCLK_UART2>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		uart3: serial at 12860000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x12860000 0x100>;
+			interrupts = <0 145 0>;
+			clocks = <&clock_aud AUD_CLK_AUD_UART>, <&clock_aud AUD_SCLK_AUD_UART>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		mmc_0: mmc0 at 12140000 {
+			compatible = "samsung,exynos5250-dw-mshc";
+			reg = <0x12140000 0x2000>;
+			interrupts = <0 156 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_fsys FSYS_CLK_MMC0>, <&clock_top TOP_SCLK_MMC0>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <64>;
+			status = "disabled";
+		};
+
+		mmc_1: mmc1 at 12150000 {
+			compatible = "samsung,exynos5250-dw-mshc";
+			reg = <0x12150000 0x2000>;
+			interrupts = <0 158 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_fsys FSYS_CLK_MMC1>, <&clock_top TOP_SCLK_MMC1>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <64>;
+			status = "disabled";
+		};
+
+		mmc_2: mmc2 at 12160000 {
+			compatible = "samsung,exynos5250-dw-mshc";
+			reg = <0x12160000 0x2000>;
+			interrupts = <0 159 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_fsys FSYS_CLK_MMC2>, <&clock_top TOP_SCLK_MMC2>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <64>;
+			status = "disabled";
+		};
+	};
+};
+
+#include "exynos5260-pinctrl.dtsi"
-- 
1.7.9.5
