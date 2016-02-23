From: adam.buchbinder@gmail.com (Adam Buchbinder)
Date: Tue, 23 Feb 2016 15:26:05 -0800
Subject: [PATCH] ARM: Fix misspellings in comments.
Message-ID: <1456269965-25963-1-git-send-email-adam.buchbinder@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 arch/arm/boot/dts/exynos3250.dtsi                    | 4 ++--
 arch/arm/boot/dts/exynos4.dtsi                       | 2 +-
 arch/arm/boot/dts/exynos4210.dtsi                    | 4 ++--
 arch/arm/boot/dts/exynos4212.dtsi                    | 4 ++--
 arch/arm/boot/dts/exynos4412.dtsi                    | 4 ++--
 arch/arm/boot/dts/exynos4x12.dtsi                    | 4 ++--
 arch/arm/boot/dts/exynos5.dtsi                       | 2 +-
 arch/arm/boot/dts/exynos5250.dtsi                    | 2 +-
 arch/arm/boot/dts/exynos5410.dtsi                    | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi                    | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi                    | 2 +-
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi            | 2 +-
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi            | 2 +-
 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi | 2 +-
 arch/arm/boot/dts/r8a7779.dtsi                       | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi                       | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi                       | 2 +-
 arch/arm/boot/dts/r8a7794.dtsi                       | 2 +-
 arch/arm/boot/dts/s3c6400.dtsi                       | 4 ++--
 arch/arm/boot/dts/s3c6410.dtsi                       | 4 ++--
 arch/arm/boot/dts/s3c64xx.dtsi                       | 2 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi               | 4 ++--
 arch/arm/boot/dts/s5pv210.dtsi                       | 4 ++--
 arch/arm/boot/dts/tegra114.dtsi                      | 2 +-
 arch/arm/boot/dts/tegra124.dtsi                      | 2 +-
 arch/arm/boot/dts/tegra20.dtsi                       | 2 +-
 arch/arm/boot/dts/tegra30.dtsi                       | 2 +-
 arch/arm/include/asm/kvm_asm.h                       | 8 ++++----
 arch/arm/include/asm/pgtable-2level.h                | 2 +-
 arch/arm/include/asm/uaccess.h                       | 2 +-
 arch/arm/include/asm/xen/page-coherent.h             | 2 +-
 arch/arm/kernel/cpuidle.c                            | 4 ++--
 arch/arm/kernel/hyp-stub.S                           | 2 +-
 arch/arm/kernel/kgdb.c                               | 4 ++--
 arch/arm/kvm/interrupts.S                            | 2 +-
 arch/arm/mach-davinci/board-dm355-evm.c              | 2 +-
 arch/arm/mach-davinci/board-dm365-evm.c              | 2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c             | 2 +-
 arch/arm/mach-imx/mm-imx3.c                          | 2 +-
 arch/arm/mach-imx/tzic.c                             | 2 +-
 arch/arm/mach-ixp4xx/ixp4xx_npe.c                    | 2 +-
 arch/arm/mach-omap1/clock_data.c                     | 2 +-
 arch/arm/mach-omap2/dma.c                            | 2 +-
 arch/arm/mach-pxa/include/mach/palmtx.h              | 2 +-
 arch/arm/mach-pxa/include/mach/trizeps4.h            | 2 +-
 arch/arm/mach-pxa/palmt5.h                           | 2 +-
 arch/arm/mach-pxa/palmte2.h                          | 2 +-
 arch/arm/mach-pxa/palmz72.h                          | 2 +-
 arch/arm/mach-s3c24xx/bast.h                         | 2 +-
 arch/arm/mach-s3c24xx/vr1000.h                       | 2 +-
 arch/arm/mach-s3c64xx/include/mach/irqs.h            | 2 +-
 arch/arm/mach-s5pv210/regs-clock.h                   | 2 +-
 arch/arm/mach-tegra/pm.c                             | 2 +-
 arch/arm/mm/context.c                                | 4 ++--
 arch/arm/plat-omap/dmtimer.c                         | 2 +-
 arch/arm/plat-samsung/include/plat/gpio-cfg.h        | 2 +-
 arch/arm/probes/kprobes/test-core.c                  | 2 +-
 arch/arm/xen/hypercall.S                             | 4 ++--
 58 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 18e3def..9a2afec 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -5,8 +5,8 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos3250 SoC device nodes are listed in this file. Exynos3250
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos3250 SoC. As device tree coverage for Exynos3250 increases, additional
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 045785c..5503d54 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -8,7 +8,7 @@
  *
  * Samsung's Exynos4 SoC series device nodes are listed in this file.  Particular
  * SoCs from Exynos4 series can include this file and provide values for SoCs
- * specfic bindings.
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4 SoCs. As device tree coverage for Exynos4 increases, additional
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index c1cb8df..ba1852a 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -7,8 +7,8 @@
  *		www.linaro.org
  *
  * Samsung's Exynos4210 SoC device nodes are listed in this file. Exynos4210
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4210 SoC. As device tree coverage for Exynos4210 increases, additional
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 5389011..d993eb0 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -5,8 +5,8 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos4212 SoC device nodes are listed in this file. Exynos4212
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4212 SoC. As device tree coverage for Exynos4212 increases, additional
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 40beede..0896878 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -5,8 +5,8 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos4412 SoC device nodes are listed in this file. Exynos4412
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4412 SoC. As device tree coverage for Exynos4412 increases, additional
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 84a23f9..7358359 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -5,8 +5,8 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos4x12 SoCs device nodes are listed in this file. Exynos4x12
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4x12 SoC. As device tree coverage for Exynos4x12 increases, additional
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index e2439e8..7ef446c 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -6,7 +6,7 @@
  *
  * Samsung's Exynos5 SoC series device nodes are listed in this file. Particular
  * SoCs from Exynos5 series can include this file and provide values for SoCs
- * specfic bindings.
+ * specific bindings.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 33e2d5f..b576611 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -6,7 +6,7 @@
  *
  * SAMSUNG EXYNOS5250 SoC device nodes are listed in this file.
  * EXYNOS5250 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * EXYNOS5250 SoC. As device tree coverage for EXYNOS5250 increases,
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index fad0779..dfc01c6 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -6,7 +6,7 @@
  *
  * SAMSUNG EXYNOS5410 SoC device nodes are listed in this file.
  * EXYNOS5410 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 48a0a55..55373f4 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -6,7 +6,7 @@
  *
  * SAMSUNG EXYNOS54200 SoC device nodes are listed in this file.
  * EXYNOS5420 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..15d98bf 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -6,7 +6,7 @@
  *
  * SAMSUNG EXYNOS5800 SoC device nodes are listed in this file.
  * EXYNOS5800 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
index 445fafc..9c74c99 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -1,7 +1,7 @@
 /*
  * Common file for GPMC connected smsc911x on omaps
  *
- * Note that the board specifc DTS file needs to specify
+ * Note that the board specific DTS file needs to specify
  * ranges, pinctrl, reg, interrupt parent and interrupts.
  */
 
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
index 73e272f..7f37b00 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
@@ -5,7 +5,7 @@
  * or smsc 9218) has faster timings, leading to higher
  * bandwidth.
  *
- * Note that the board specifc DTS file needs to specify
+ * Note that the board specific DTS file needs to specify
  * ranges, pinctrl, reg, interrupt parent and interrupts.
  */
 
diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
index 157345b..3a26dbf 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -1,7 +1,7 @@
 /*
  * Common file for omap dpi panels with QVGA and reset pins
  *
- * Note that the board specifc DTS file needs to specify
+ * Note that the board specific DTS file needs to specify
  * at minimum the GPIO enable-gpios for display, and
  * gpios for gpio-backlight.
  */
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 6afa909..f3e2925 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -436,7 +436,7 @@
 		extal_clk: extal_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			/* This value must be overriden by the board. */
+			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
 			clock-output-names = "extal";
 		};
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7dfd393..717dece 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -949,7 +949,7 @@
 		extal_clk: extal_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			/* This value must be overriden by the board. */
+			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
 			clock-output-names = "extal";
 		};
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2a369dd..1bb450e 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -994,7 +994,7 @@
 		extal_clk: extal_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			/* This value must be overriden by the board. */
+			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
 			clock-output-names = "extal";
 		};
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6c78f1f..2b52360 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -792,7 +792,7 @@
 		extal_clk: extal_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			/* This value must be overriden by the board. */
+			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
 			clock-output-names = "extal";
 		};
diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/s3c6400.dtsi
index a7d1c8e..fc371bb 100644
--- a/arch/arm/boot/dts/s3c6400.dtsi
+++ b/arch/arm/boot/dts/s3c6400.dtsi
@@ -4,8 +4,8 @@
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
  * Samsung's S3C6400 SoC device nodes are listed in this file. S3C6400
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * S3C6400 SoC. As device tree coverage for S3C6400 increases, additional
diff --git a/arch/arm/boot/dts/s3c6410.dtsi b/arch/arm/boot/dts/s3c6410.dtsi
index eb4226b..c527033 100644
--- a/arch/arm/boot/dts/s3c6410.dtsi
+++ b/arch/arm/boot/dts/s3c6410.dtsi
@@ -4,8 +4,8 @@
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
  * Samsung's S3C6410 SoC device nodes are listed in this file. S3C6410
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * S3C6410 SoC. As device tree coverage for S3C6410 increases, additional
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 0ccb414..3852736 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -5,7 +5,7 @@
  *
  * Samsung's S3C64xx SoC series device nodes are listed in this file.
  * Particular SoCs from S3C64xx series can include this file and provide
- * values for SoCs specfic bindings.
+ * values for SoCs specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * S3C64xx SoCs. As device tree coverage for S3C64xx increases, additional
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 8c71408..4b1bbe6 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -7,8 +7,8 @@
  * Tomasz Figa <t.figa@samsung.com>
  *
  * Samsung's S5PV210 SoC device nodes are listed in this file. S5PV210
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * S5PV210 SoC. As device tree coverage for S5PV210 increases, additional
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 8344a0e..e030218 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -7,8 +7,8 @@
  * Tomasz Figa <t.figa@samsung.com>
  *
  * Samsung's S5PV210 SoC device nodes are listed in this file. S5PV210
- * based board files can include this file and provide values for board specfic
- * bindings.
+ * based board files can include this file and provide values for board
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * S5PV210 SoC. As device tree coverage for S5PV210 increases, additional
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index d845bd1..f9a700f 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -254,7 +254,7 @@
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-	 * and performace. To enable the 8250 based driver, the compatible
+	 * and performance. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra114-uart", "nvidia,tegra20-uart" and to enable
 	 * the APB DMA based serial driver, the comptible is
 	 * "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart".
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 68669f7..260bc1f 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -320,7 +320,7 @@
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-	 * and performace. To enable the 8250 based driver, the compatible
+	 * and performance. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra124-uart", "nvidia,tegra20-uart" and to enable
 	 * the APB DMA based serial driver, the comptible is
 	 * "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart".
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 33173e1..503c5df 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -307,7 +307,7 @@
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-	 * and performace. To enable the 8250 based driver, the compatible
+	 * and performance. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra20-uart" and to enable the APB DMA based serial
 	 * driver, the comptible is "nvidia,tegra20-hsuart".
 	 */
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 313e260..35e21c0 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -369,7 +369,7 @@
 	/*
 	 * There are two serial driver i.e. 8250 based simple serial
 	 * driver and APB DMA based serial driver for higher baudrate
-	 * and performace. To enable the 8250 based driver, the compatible
+	 * and performance. To enable the 8250 based driver, the compatible
 	 * is "nvidia,tegra30-uart", "nvidia,tegra20-uart" and to enable
 	 * the APB DMA based serial driver, the comptible is
 	 * "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 194c91b..c5d0af5 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -33,8 +33,8 @@
 #define c3_DACR		11	/* Domain Access Control Register */
 #define c5_DFSR		12	/* Data Fault Status Register */
 #define c5_IFSR		13	/* Instruction Fault Status Register */
-#define c5_ADFSR	14	/* Auxilary Data Fault Status R */
-#define c5_AIFSR	15	/* Auxilary Instrunction Fault Status R */
+#define c5_ADFSR	14	/* Auxiliary Data Fault Status R */
+#define c5_AIFSR	15	/* Auxiliary Instrunction Fault Status R */
 #define c6_DFAR		16	/* Data Fault Address Register */
 #define c6_IFAR		17	/* Instruction Fault Address Register */
 #define c7_PAR		18	/* Physical Address Register */
@@ -48,8 +48,8 @@
 #define c13_TID_URO	26	/* Thread ID, User R/O */
 #define c13_TID_PRIV	27	/* Thread ID, Privileged */
 #define c14_CNTKCTL	28	/* Timer Control Register (PL1) */
-#define c10_AMAIR0	29	/* Auxilary Memory Attribute Indirection Reg0 */
-#define c10_AMAIR1	30	/* Auxilary Memory Attribute Indirection Reg1 */
+#define c10_AMAIR0	29	/* Aux Memory Attribute Indirection Reg0 */
+#define c10_AMAIR1	30	/* Aux Memory Attribute Indirection Reg1 */
 #define NR_CP15_REGS	31	/* Number of regs (incl. invalid) */
 
 #define ARM_EXCEPTION_RESET	  0
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index aeddd28..b37ca84 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -66,7 +66,7 @@
  *
  * However, when the "young" bit is cleared, we deny access to the page
  * by clearing the hardware PTE.  Currently Linux does not flush the TLB
- * for us in this case, which means the TLB will retain the transation
+ * for us in this case, which means the TLB will retain the transaction
  * until either the TLB entry is evicted under pressure, or a context
  * switch which changes the user space mapping occurs.
  */
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 35c9db8..553ae49 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -53,7 +53,7 @@ extern int fixup_exception(struct pt_regs *regs);
  * These two functions allow hooking accesses to userspace to increase
  * system integrity by ensuring that the kernel can not inadvertantly
  * perform such accesses (eg, via list poison values) which could then
- * be exploited for priviledge escalation.
+ * be exploited for privilege escalation.
  */
 static inline unsigned int uaccess_save_and_enable(void)
 {
diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index 9408a99..55cb181 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -63,7 +63,7 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 {
 	unsigned long pfn = PFN_DOWN(handle);
 	/*
-	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
+	 * Dom0 is mapped 1:1, while the Linux page can be spanned across
 	 * multiple Xen page, it's not possible to have a mix of local and
 	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
 	 * foreign mfn will always return false. If the page is local we can
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 703926e..b307410 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -91,8 +91,8 @@ static struct cpuidle_ops *__init arm_cpuidle_get_ops(const char *method)
  * cpuidle_ops are tagged __initdata and will be unloaded after the init
  * process.
  *
- * Return 0 on sucess, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP if
- * no cpuidle_ops is registered for the 'enable-method'.
+ * Return 0 on success, -ENOENT if no 'enable-method' is defined, -EOPNOTSUPP
+ * if no cpuidle_ops is registered for the 'enable-method'.
  */
 static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 {
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 2a55373..91e98cd 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -49,7 +49,7 @@ ENTRY(__boot_cpu_mode)
 	 * Compare the current mode with the one saved on the primary CPU.
 	 * If they don't match, record that fact. The Z bit indicates
 	 * if there's a match or not.
-	 * Requires 3 additionnal scratch registers.
+	 * Requires 3 additional scratch registers.
 	 */
 	.macro	compare_cpu_mode_with_primary mode, reg1, reg2, reg3
 	adr	\reg2, .L__boot_cpu_mode_offset
diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index 9232cae..091f05f 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -209,9 +209,9 @@ static struct notifier_block kgdb_notifier = {
 
 
 /**
- *	kgdb_arch_init - Perform any architecture specific initalization.
+ *	kgdb_arch_init - Perform any architecture specific initialization.
  *
- *	This function will handle the initalization of any architecture
+ *	This function will handle the initialization of any architecture
  *	specific callbacks.
  */
 int kgdb_arch_init(void)
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 900ef6d..30bded6 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -353,7 +353,7 @@ hyp_dabt:
 	.align
 hyp_hvc:
 	/*
-	 * Getting here is either becuase of a trap from a guest or from calling
+	 * Getting here is either because of a trap from a guest or from calling
 	 * HVC from the host kernel, which means "switch to Hyp mode".
 	 */
 	push	{r0, r1, r2}
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 1844076..37f6b63 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -202,7 +202,7 @@ static struct v4l2_input tvp5146_inputs[] = {
 
 /*
  * this is the route info for connecting each input to decoder
- * ouput that goes to vpfe. There is a one to one correspondence
+ * output that goes to vpfe. There is a one to one correspondence
  * with tvp5146_inputs
  */
 static struct vpfe_route tvp5146_routes[] = {
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index f073518..9d15f42 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -333,7 +333,7 @@ static struct v4l2_input tvp5146_inputs[] = {
 
 /*
  * this is the route info for connecting each input to decoder
- * ouput that goes to vpfe. There is a one to one correspondence
+ * output that goes to vpfe. There is a one to one correspondence
  * with tvp5146_inputs
  */
 static struct vpfe_route tvp5146_routes[] = {
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 7a20507..090aad8 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -217,7 +217,7 @@ static struct v4l2_input dm644xevm_tvp5146_inputs[] = {
 
 /*
  * this is the route info for connecting each input to decoder
- * ouput that goes to vpfe. There is a one to one correspondence
+ * output that goes to vpfe. There is a one to one correspondence
  * with tvp5146_inputs
  */
 static struct vpfe_route dm644xevm_tvp5146_routes[] = {
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 0884ca9..8774fdb 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -90,7 +90,7 @@ static void __init imx3_init_l2x0(void)
 
 /*
  * First of all, we must repair broken chip settings. There are some
- * i.MX35 CPUs in the wild, comming with bogus L2 cache settings. These
+ * i.MX35 CPUs in the wild, coming with bogus L2 cache settings. These
  * misconfigured CPUs will run amok immediately when the L2 cache gets enabled.
  * Workaraound is to setup the correct register setting prior enabling the
  * L2 cache. This should not hurt already working CPUs, as they are using the
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 4de65ee..50fe4f1 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -48,7 +48,7 @@
 #define TZIC_HIPND(i)	(0x0D80+ ((i) << 2))	/* High Priority Pending Register */
 #define TZIC_WAKEUP0(i)	(0x0E00 + ((i) << 2))	/* Wakeup Config Register */
 #define TZIC_SWINT	0x0F00	/* Software Interrupt Rigger Register */
-#define TZIC_ID0	0x0FD0	/* Indentification Register 0 */
+#define TZIC_ID0	0x0FD0	/* Identification Register 0 */
 
 static void __iomem *tzic_base;
 static struct irq_domain *domain;
diff --git a/arch/arm/mach-ixp4xx/ixp4xx_npe.c b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
index d4eb09a..548b675 100644
--- a/arch/arm/mach-ixp4xx/ixp4xx_npe.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
@@ -317,7 +317,7 @@ static int npe_reset(struct npe *npe)
 			  __raw_readl(&npe->regs->in_out_fifo));
 
 	while (__raw_readl(&npe->regs->messaging_status) & MSGSTAT_IFNE)
-		/* step execution of the NPE intruction to read inFIFO using
+		/* step execution of the NPE instruction to read inFIFO using
 		   the Debug Executing Context stack */
 		if (npe_debug_instr(npe, INSTR_RD_FIFO, 0, 0))
 			return -ETIMEDOUT;
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 6c4f766..460d9bc 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -821,7 +821,7 @@ int __init omap1_clk_init(void)
 		omap_readw(ARM_SYSST), omap_readw(DPLL_CTL),
 		omap_readw(ARM_CKCTL));
 
-	/* We want to be in syncronous scalable mode */
+	/* We want to be in synchronous scalable mode */
 	omap_writew(0x1000, ARM_SYSST);
 
 
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 1ed4be1..1a1efb5 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -159,7 +159,7 @@ static unsigned configure_dma_errata(void)
 	/*
 	 * Erratum ID: i378: OMAP2+: sDMA Channel is not disabled
 	 * after a transaction error.
-	 * Workaround: SW should explicitely disable the channel.
+	 * Workaround: SW should explicitly disable the channel.
 	 */
 	if (cpu_class_is_omap2())
 		SET_DMA_ERRATA(DMA_ERRATA_i378);
diff --git a/arch/arm/mach-pxa/include/mach/palmtx.h b/arch/arm/mach-pxa/include/mach/palmtx.h
index 92bc1f0..ca29d9d 100644
--- a/arch/arm/mach-pxa/include/mach/palmtx.h
+++ b/arch/arm/mach-pxa/include/mach/palmtx.h
@@ -35,7 +35,7 @@
 /* TOUCHSCREEN */
 #define GPIO_NR_PALMTX_WM9712_IRQ		27
 
-/* IRDA -  disable GPIO connected to SD pin of tranceiver (TFBS4710?) ? */
+/* IRDA -  disable GPIO connected to SD pin of transceiver (TFBS4710?) ? */
 #define GPIO_NR_PALMTX_IR_DISABLE		40
 
 /* USB */
diff --git a/arch/arm/mach-pxa/include/mach/trizeps4.h b/arch/arm/mach-pxa/include/mach/trizeps4.h
index ae3ca01..f647272 100644
--- a/arch/arm/mach-pxa/include/mach/trizeps4.h
+++ b/arch/arm/mach-pxa/include/mach/trizeps4.h
@@ -100,7 +100,7 @@ static inline unsigned short CFSR_readw(void)
 }
 static inline void BCR_writew(unsigned short value)
 {
-	/* [Board Control Regsiter] is write only */
+	/* [Board Control Register] is write only */
 	*((unsigned short *)BCR_P2V(0x0E000000)) = value;
 }
 static inline void DCR_writew(unsigned short value)
diff --git a/arch/arm/mach-pxa/palmt5.h b/arch/arm/mach-pxa/palmt5.h
index f850cc9..a27cda9 100644
--- a/arch/arm/mach-pxa/palmt5.h
+++ b/arch/arm/mach-pxa/palmt5.h
@@ -34,7 +34,7 @@
 /* TOUCHSCREEN */
 #define GPIO_NR_PALMT5_WM9712_IRQ		27
 
-/* IRDA - disable GPIO connected to SD pin of tranceiver (TFBS4710?) ? */
+/* IRDA - disable GPIO connected to SD pin of transceiver (TFBS4710?) ? */
 #define GPIO_NR_PALMT5_IR_DISABLE		40
 
 /* USB */
diff --git a/arch/arm/mach-pxa/palmte2.h b/arch/arm/mach-pxa/palmte2.h
index f89e989..17a9bac 100644
--- a/arch/arm/mach-pxa/palmte2.h
+++ b/arch/arm/mach-pxa/palmte2.h
@@ -25,7 +25,7 @@
 #define GPIO_NR_PALMTE2_SD_POWER		55
 #define GPIO_NR_PALMTE2_SD_READONLY		51
 
-/* IRDA -  disable GPIO connected to SD pin of tranceiver (TFBS4710?) ? */
+/* IRDA -  disable GPIO connected to SD pin of transceiver (TFBS4710?) ? */
 #define GPIO_NR_PALMTE2_IR_DISABLE		48
 
 /* USB */
diff --git a/arch/arm/mach-pxa/palmz72.h b/arch/arm/mach-pxa/palmz72.h
index 0d4700a..1f992c3 100644
--- a/arch/arm/mach-pxa/palmz72.h
+++ b/arch/arm/mach-pxa/palmz72.h
@@ -26,7 +26,7 @@
 /* Touchscreen */
 #define GPIO_NR_PALMZ72_WM9712_IRQ		27
 
-/* IRDA -  disable GPIO connected to SD pin of tranceiver (TFBS4710?) ? */
+/* IRDA -  disable GPIO connected to SD pin of transceiver (TFBS4710?) ? */
 #define GPIO_NR_PALMZ72_IR_DISABLE		49
 
 /* USB */
diff --git a/arch/arm/mach-s3c24xx/bast.h b/arch/arm/mach-s3c24xx/bast.h
index 5c7534b..a22ea49 100644
--- a/arch/arm/mach-s3c24xx/bast.h
+++ b/arch/arm/mach-s3c24xx/bast.h
@@ -149,7 +149,7 @@
  * 0x02500000 to 0x02600000 1MB  Davicom DM9000 ethernet controller
  * 0x02600000 to 0x02700000 1MB  PC SuperIO controller
  *
- * the phyiscal layout of the zones are:
+ * the physical layout of the zones are:
  *  nGCS2 - 8bit, slow
  *  nGCS3 - 16bit, slow
  *  nGCS4 - 16bit, net
diff --git a/arch/arm/mach-s3c24xx/vr1000.h b/arch/arm/mach-s3c24xx/vr1000.h
index 7fcd2c2..e3d92e8 100644
--- a/arch/arm/mach-s3c24xx/vr1000.h
+++ b/arch/arm/mach-s3c24xx/vr1000.h
@@ -78,7 +78,7 @@
  * 0x02500000 to 0x02600000 1MB  Davicom DM9000 ethernet controllers
  * 0x02600000 to 0x02700000 1MB
  *
- * the phyiscal layout of the zones are:
+ * the physical layout of the zones are:
  *  nGCS2 - 8bit, slow
  *  nGCS3 - 16bit, slow
  *  nGCS4 - 16bit, net
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
index 3ceb00b..28990b0 100644
--- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
@@ -17,7 +17,7 @@
  * standard ISA drivers....
  *
  * note, since we're using the VICs, our start must be a
- * mulitple of 32 to allow the common code to work
+ * multiple of 32 to allow the common code to work
  */
 
 #define S3C_IRQ_OFFSET	(32)
diff --git a/arch/arm/mach-s5pv210/regs-clock.h b/arch/arm/mach-s5pv210/regs-clock.h
index 4640f0f..4c035a4 100644
--- a/arch/arm/mach-s5pv210/regs-clock.h
+++ b/arch/arm/mach-s5pv210/regs-clock.h
@@ -187,7 +187,7 @@
 #define S5P_SLEEP_CFG_OSC_EN		(1 << 0)
 #define S5P_SLEEP_CFG_USBOSC_EN		(1 << 1)
 
-/* OTHERS Resgister */
+/* OTHERS Register */
 #define S5P_OTHERS_RET_IO		(1 << 31)
 #define S5P_OTHERS_RET_CF		(1 << 30)
 #define S5P_OTHERS_RET_MMC		(1 << 29)
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index b0f48a3..e7de9b9 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -228,7 +228,7 @@ static int tegra_sleep_core(unsigned long v2p)
  * tegra_lp1_iram_hook
  *
  * Hooking the address of LP1 reset vector and SDRAM self-refresh code in
- * SDRAM. These codes not be copied to IRAM in this fuction. We need to
+ * SDRAM. These codes not be copied to IRAM in this function. We need to
  * copy these code to IRAM before LP0/LP1 suspend and restore the content
  * of IRAM after resume.
  */
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index c8c8b9e..d982207 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -79,7 +79,7 @@ void a15_erratum_get_cpumask(int this_cpu, struct mm_struct *mm,
 
 #ifdef CONFIG_ARM_LPAE
 /*
- * With LPAE, the ASID and page tables are updated atomicly, so there is
+ * With LPAE, the ASID and page tables are updated atomically, so there is
  * no need for a reserved set of tables (the active ASID tracking prevents
  * any issues across a rollover).
  */
@@ -247,7 +247,7 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 		__check_vmalloc_seq(mm);
 
 	/*
-	 * We cannot update the pgd and the ASID atomicly with classic
+	 * We cannot update the pgd and the ASID atomically with classic
 	 * MMU, so switch exclusively to global mappings to avoid
 	 * speculative page table walking with the wrong TTBR.
 	 */
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7a327bd..1f90aa4 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -255,7 +255,7 @@ static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 				/*
 				 * If timer is not NULL, we have already found
 				 * one timer but it was not an exact match
-				 * because it had more capabilites that what
+				 * because it had more capabilities that what
 				 * was required. Therefore, unreserve the last
 				 * timer found and see if this one is a better
 				 * match.
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index b5294ef..ae61176 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -40,7 +40,7 @@ struct samsung_gpio_chip;
  * @get_config: Read the current configuration for the GPIO
  *
  * Each chip can have more than one type of GPIO bank available and some
- * have different capabilites even when they have the same control register
+ * have different capabilities even when they have the same control register
  * layouts. Provide an point to vector control routine and provide any
  * per-bank configuration information that other systems such as the
  * external interrupt code will need.
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 9775de2..ddd9f8c 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -128,7 +128,7 @@
  *	.byte	ARG_TYPE_END
  *	.byte	TEST_ISA	@ flags, including ISA being tested
  *	.short	50f-0f		@ offset of 'test_before'
- *	.short	2f-0f		@ offset of 'test_after2' (if relevent)
+ *	.short	2f-0f		@ offset of 'test_after2' (if relevant)
  *	.short	99f-0f		@ offset of 'test_done'
  *	@ start of test case code...
  *	0:
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index 9a36f4f..d49b04a 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -32,9 +32,9 @@
 
 /*
  * The Xen hypercall calling convention is very similar to the ARM
- * procedure calling convention: the first paramter is passed in r0, the
+ * procedure calling convention: the first parameter is passed in r0, the
  * second in r1, the third in r2 and the fourth in r3. Considering that
- * Xen hypercalls have 5 arguments at most, the fifth paramter is passed
+ * Xen hypercalls have 5 arguments@most, the fifth parameter is passed
  * in r4, differently from the procedure calling convention of using the
  * stack for that case.
  *
-- 
2.7.0.rc3.207.g0ac5344
