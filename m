From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 09 Oct 2014 19:24:33 +0530
Subject: [PATCH v5 5/6] arm64: dts: Add initial pinctrl support to EXYNOS7
In-Reply-To: <1412862874-9335-1-git-send-email-a.kesavan@samsung.com>
References: <1412862874-9335-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1412862874-9335-6-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>

Add initial pin configuration nodes for EXYNOS7.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi |  560 +++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   66 +++
 2 files changed, 626 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
new file mode 100644
index 0000000..c7c41c1
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
@@ -0,0 +1,560 @@
+/*
+ * Samsung's Exynos7 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos7 SoC pin-mux and pin-config options are listed as
+ * device tree nodes in this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+&pinctrl_alive {
+	gpa0: gpa0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <2>;
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>;
+	};
+
+	gpa1: gpa1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <2>;
+		interrupts = <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
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
+	gpa3: gpa3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_bus0 {
+	gpb0: gpb0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
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
+	gpd4: gpd4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd5: gpd5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd6: gpd6 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd7: gpd7 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd8: gpd8 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg0: gpg0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg3: gpg3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	hs_i2c10_bus: hs-i2c10-bus {
+		samsung,pins = "gpb0-1", "gpb0-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c11_bus: hs-i2c11-bus {
+		samsung,pins = "gpb0-3", "gpb0-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c2_bus: hs-i2c2-bus {
+		samsung,pins = "gpd0-3", "gpd0-2";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart0_data: uart0-data {
+		samsung,pins = "gpd0-0", "gpd0-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart0_fctl: uart0-fctl {
+		samsung,pins = "gpd0-2", "gpd0-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart2_data: uart2-data {
+		samsung,pins = "gpd1-4", "gpd1-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c3_bus: hs-i2c3-bus {
+		samsung,pins = "gpd1-3", "gpd1-2";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart1_data: uart1-data {
+		samsung,pins = "gpd1-0", "gpd1-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart1_fctl: uart1-fctl {
+		samsung,pins = "gpd1-2", "gpd1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c0_bus: hs-i2c0-bus {
+		samsung,pins = "gpd2-1", "gpd2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c1_bus: hs-i2c1-bus {
+		samsung,pins = "gpd2-3", "gpd2-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c9_bus: hs-i2c9-bus {
+		samsung,pins = "gpd2-7", "gpd2-6";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c8_bus: hs-i2c8-bus {
+		samsung,pins = "gpd5-3", "gpd5-2";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart3_data: uart3-data {
+		samsung,pins = "gpd5-0", "gpd5-1";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi2_bus: spi2-bus {
+		samsung,pins = "gpd5-0", "gpd5-1", "gpd5-2", "gpd5-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi1_bus: spi1-bus {
+		samsung,pins = "gpd6-2", "gpd6-3", "gpd6-4", "gpd6-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi0_bus: spi0-bus {
+		samsung,pins = "gpd8-0", "gpd8-1", "gpd6-0", "gpd6-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c4_bus: hs-i2c4-bus {
+		samsung,pins = "gpg3-1", "gpg3-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c5_bus: hs-i2c5-bus {
+		samsung,pins = "gpg3-3", "gpg3-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_nfc {
+	gpj0: gpj0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	hs_i2c6_bus: hs-i2c6-bus {
+		samsung,pins = "gpj0-1", "gpj0-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_touch {
+	gpj1: gpj1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	hs_i2c7_bus: hs-i2c7-bus {
+		samsung,pins = "gpj1-1", "gpj1-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_ff {
+	gpg4: gpg4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	spi3_bus: spi3-bus {
+		samsung,pins = "gpg4-0", "gpg4-1", "gpg4-2", "gpg4-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_ese {
+	gpv7: gpv7 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	spi4_bus: spi4-bus {
+		samsung,pins = "gpv7-0", "gpv7-1", "gpv7-2", "gpv7-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_fsys0 {
+	gpr4: gpr4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sd2_clk: sd2-clk {
+		samsung,pins = "gpr4-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cmd: sd2-cmd {
+		samsung,pins = "gpr4-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cd: sd2-cd {
+		samsung,pins = "gpr4-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus1: sd2-bus-width1 {
+		samsung,pins = "gpr4-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus4: sd2-bus-width4 {
+		samsung,pins = "gpr4-4", "gpr4-5", "gpr4-6";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+};
+
+&pinctrl_fsys1 {
+	gpr0: gpr0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr1: gpr1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr2: gpr2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr3: gpr3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	sd0_clk: sd0-clk {
+		samsung,pins = "gpr0-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_cmd: sd0-cmd {
+		samsung,pins = "gpr0-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_ds: sd0-ds {
+		samsung,pins = "gpr0-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_qrdy: sd0-qrdy {
+		samsung,pins = "gpr0-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus1: sd0-bus-width1 {
+		samsung,pins = "gpr1-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus4: sd0-bus-width4 {
+		samsung,pins = "gpr1-1", "gpr1-2", "gpr1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus8: sd0-bus-width8 {
+		samsung,pins = "gpr1-4", "gpr1-5", "gpr1-6", "gpr1-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_clk: sd1-clk {
+		samsung,pins = "gpr2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <2>;
+	};
+
+	sd1_cmd: sd1-cmd {
+		samsung,pins = "gpr2-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <2>;
+	};
+
+	sd1_ds: sd1-ds {
+		samsung,pins = "gpr2-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <6>;
+	};
+
+	sd1_qrdy: sd1-qrdy {
+		samsung,pins = "gpr2-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <6>;
+	};
+
+	sd1_int: sd1-int {
+		samsung,pins = "gpr2-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <6>;
+	};
+
+	sd1_bus1: sd1-bus-width1 {
+		samsung,pins = "gpr3-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <2>;
+	};
+
+	sd1_bus4: sd1-bus-width4 {
+		samsung,pins = "gpr3-1", "gpr3-2", "gpr3-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <2>;
+	};
+
+	sd1_bus8: sd1-bus-width8 {
+		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index a326fbf..ce221ac 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -17,6 +17,17 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		pinctrl0 = &pinctrl_alive;
+		pinctrl1 = &pinctrl_bus0;
+		pinctrl2 = &pinctrl_nfc;
+		pinctrl3 = &pinctrl_touch;
+		pinctrl4 = &pinctrl_ff;
+		pinctrl5 = &pinctrl_ese;
+		pinctrl6 = &pinctrl_fsys0;
+		pinctrl7 = &pinctrl_fsys1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -172,6 +183,59 @@
 			status = "disabled";
 		};
 
+		pinctrl_alive: pinctrl at 10580000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x10580000 0x1000>;
+
+			wakeup-interrupt-controller {
+				compatible = "samsung,exynos7-wakeup-eint";
+				interrupt-parent = <&gic>;
+				interrupts = <0 16 0>;
+			};
+		};
+
+		pinctrl_bus0: pinctrl at 13470000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x13470000 0x1000>;
+			interrupts = <0 383 0>;
+		};
+
+		pinctrl_nfc: pinctrl at 14cd0000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x14cd0000 0x1000>;
+			interrupts = <0 473 0>;
+		};
+
+		pinctrl_touch: pinctrl at 14ce0000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x14ce0000 0x1000>;
+			interrupts = <0 474 0>;
+		};
+
+		pinctrl_ff: pinctrl at 14c90000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x14c90000 0x1000>;
+			interrupts = <0 475 0>;
+		};
+
+		pinctrl_ese: pinctrl at 14ca0000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x14ca0000 0x1000>;
+			interrupts = <0 476 0>;
+		};
+
+		pinctrl_fsys0: pinctrl at 10e60000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x10e60000 0x1000>;
+			interrupts = <0 221 0>;
+		};
+
+		pinctrl_fsys1: pinctrl at 15690000 {
+			compatible = "samsung,exynos7-pinctrl";
+			reg = <0x15690000 0x1000>;
+			interrupts = <0 203 0>;
+		};
+
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <1 13 0xff01>,
@@ -181,3 +245,5 @@
 		};
 	};
 };
+
+#include "exynos7-pinctrl.dtsi"
-- 
1.7.9.5
