From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 25 Dec 2017 11:40:09 +0100
Subject: [PATCH 1/5] ARM: dts: exynos: Add SPDX license identifier
Message-ID: <1514198413-4358-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL v2.0 license with a SPDX license indentifier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       | 5 +----
 arch/arm/boot/dts/exynos3250-artik5.dtsi           | 5 +----
 arch/arm/boot/dts/exynos3250-monk.dts              | 5 +----
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos3250-rinato.dts            | 5 +----
 arch/arm/boot/dts/exynos3250.dtsi                  | 5 +----
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         | 6 +-----
 arch/arm/boot/dts/exynos4.dtsi                     | 5 +----
 arch/arm/boot/dts/exynos4210-origen.dts            | 7 ++-----
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos4210-smdkv310.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4210-trats.dts             | 7 ++-----
 arch/arm/boot/dts/exynos4210-universal_c210.dts    | 7 ++-----
 arch/arm/boot/dts/exynos4210.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 5 +----
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 5 +----
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 5 +----
 arch/arm/boot/dts/exynos4412-odroidu3.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4412-odroidx.dts           | 7 ++-----
 arch/arm/boot/dts/exynos4412-odroidx2.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4412-origen.dts            | 7 ++-----
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      | 5 +----
 arch/arm/boot/dts/exynos4412-prime.dtsi            | 5 +----
 arch/arm/boot/dts/exynos4412-smdk4412.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4412.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos5.dtsi                     | 5 +----
 arch/arm/boot/dts/exynos5250-arndale.dts           | 5 +----
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos5250-smdk5250.dts          | 5 +----
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 5 +----
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         | 5 +----
 arch/arm/boot/dts/exynos5250-snow.dts              | 5 +----
 arch/arm/boot/dts/exynos5250-spring.dts            | 5 +----
 arch/arm/boot/dts/exynos5250.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos5260-xyref5260.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5260.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 5 +----
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 5 +----
 arch/arm/boot/dts/exynos5410-smdk5410.dts          | 7 ++-----
 arch/arm/boot/dts/exynos5410.dtsi                  | 5 +----
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 7 ++-----
 arch/arm/boot/dts/exynos5420-cpus.dtsi             | 5 +----
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 5 +----
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos5420-smdk5420.dts          | 7 ++-----
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  | 6 +-----
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      | 6 +-----
 arch/arm/boot/dts/exynos5420.dtsi                  | 5 +----
 arch/arm/boot/dts/exynos5422-cpus.dtsi             | 5 +----
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5440-sd5v1.dts             | 7 ++-----
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          | 7 ++-----
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  | 6 +-----
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      | 6 +-----
 arch/arm/boot/dts/exynos5440.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    | 7 ++-----
 arch/arm/boot/dts/exynos54xx.dtsi                  | 5 +----
 65 files changed, 99 insertions(+), 299 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
index 4cbfa09c6c4e..20446a846a98 100644
--- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
+++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos3250 based ARTIK5 evaluation board device tree source
  *
@@ -6,10 +7,6 @@
  *
  * Device tree source file for Samsung's ARTIK5 evaluation board
  * which is based on Samsung Exynos3250 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
index 152e0291d0da..0aa577fe9f95 100644
--- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
+++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos3250 based ARTIK5 module device tree source
  *
@@ -6,10 +7,6 @@
  *
  * Device tree source file for Samsung's ARTIK5 module which is based on
  * Samsung Exynos3250 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos3250.dtsi"
diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 029eb18590cf..6ffedf4ed9f2 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos3250 based Monk board device tree source
  *
@@ -6,10 +7,6 @@
  *
  * Device tree source file for Samsung's Monk board which is based on
  * Samsung Exynos3250 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index a149f148e659..dff3c6e3aa1f 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos3250 SoCs pin-mux and pin-config device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Samsung's Exynos3250 SoCs pin-mux and pin-config optiosn are listed as device
  * tree nodes are listed in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/pinctrl/samsung.h>
 
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 3743df4de390..2c3460781cc6 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos3250 based Rinato board device tree source
  *
@@ -6,10 +7,6 @@
  *
  * Device tree source file for Samsung's Rinato board which is based on
  * Samsung Exynos3250 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 8d47571b3984..b8fb94f5daa8 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos3250 SoC device tree source
  *
@@ -11,10 +12,6 @@
  * Note: This file does not include device nodes for all the controllers in
  * Exynos3250 SoC. As device tree coverage for Exynos3250 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos4-cpu-thermal.dtsi"
diff --git a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
index 735cb2f10817..021d9fc1b492 100644
--- a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos4 thermal zone
  *
  * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index f44aa383f626..6d59cc827649 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4 SoC series common device tree source
  *
@@ -13,10 +14,6 @@
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4 SoCs. As device tree coverage for Exynos4 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/clock/exynos4.h>
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 084fcc5574ef..9a310e841d5d 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4210 based Origen board device tree source
  *
@@ -8,11 +9,7 @@
  *
  * Device tree source file for Insignal's Origen board which is based on
  * Samsung's Exynos4210 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4210.dtsi"
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 82c32d4d83d8..dbe6c052d8c1 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4210 SoC pin-mux and pin-config device tree source
  *
@@ -8,11 +9,7 @@
  *
  * Samsung's Exynos4210 SoC pin-mux and pin-config optiosn are listed as device
  * tree nodes are listed in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/pinctrl/samsung.h>
 
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 9c98a3724396..7a3e621edede 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4210 based SMDKV310 board device tree source
  *
@@ -8,11 +9,7 @@
  *
  * Device tree source file for Samsung's SMDKV310 board which is based on
  * Samsung's Exynos4210 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4210.dtsi"
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 7b6ab7265110..aaade17b140e 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4210 based Trats board device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Device tree source file for Samsung's Trats board which is based on
  * Samsung's Exynos4210 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4210.dtsi"
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index acd2b2286ccb..21fff7cd3aa4 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4210 based Universal C210 board device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Device tree source file for Samsung's Universal C210 board which is based on
  * Samsung's Exynos4210 rev0 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4210.dtsi"
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ce161ad1215d..cc978cf28267 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4210 SoC device tree source
  *
@@ -13,11 +14,7 @@
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4210 SoC. As device tree coverage for Exynos4210 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include "exynos4.dtsi"
 #include "exynos4210-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index d66093084dbb..a4cd4939fe9a 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TOPEET's Exynos4412 based itop board device tree source
  *
@@ -7,10 +8,6 @@
  *
  * Device tree source file for TOPEET iTop Exynos 4412 core board
  * which is based on Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index bda49b232f7b..ab7affab7f1c 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TOPEET's Exynos4412 based itop board device tree source
  *
@@ -7,10 +8,6 @@
  *
  * Device tree source file for TOPEET iTop Exynos 4412 SCP package core
  * board which is based on Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/clock/samsung,s2mps11.h>
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index a21be71000c1..556ea78b8e32 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Common definition for Hardkernel's Exynos4412 based ODROID-X/X2/U2/U3 boards
  * device tree source
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
 */
 
 #include <dt-bindings/sound/samsung-i2s.h>
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 44a4de08466b..bdcd4523cc1c 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel's Exynos4412 based ODROID-U3 board device tree source
  *
@@ -5,11 +6,7 @@
  *
  * Device tree source file for Hardkernel's ODROID-U3 board which is based
  * on Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4412-odroid-common.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index acf48a018e5e..2dff129bc2ad 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel's Exynos4412 based ODROID-X board device tree source
  *
@@ -5,11 +6,7 @@
  *
  * Device tree source file for Hardkernel's ODROID-X board which is based
  * on Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4412-odroid-common.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412-odroidx2.dts b/arch/arm/boot/dts/exynos4412-odroidx2.dts
index d867b2ee95ca..f4b68c75c962 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx2.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx2.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel's Exynos4412 based ODROID-X2 board device tree source
  *
@@ -5,11 +6,7 @@
  *
  * Device tree source file for Hardkernel's ODROID-X2 board which is based
  * on Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include "exynos4412-odroidx.dts"
 #include "exynos4412-prime.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index b0b5ec7903a5..1514f0dbaff8 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Insignal's Exynos4412 based Origen board device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Device tree source file for Insignal's Origen board which is based on
  * Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4412.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi b/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
index ef7b89d3db9e..e8dd5f2d976f 100644
--- a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4412 SoCs pin-mux and pin-config device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Samsung's Exynos4412 SoCs pin-mux and pin-config optiosn are listed as device
  * tree nodes are listed in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/pinctrl/samsung.h>
 
diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
index 16e4b77d8cb1..3a3b2fafefdd 100644
--- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos4412 PPMU common device tree
  *
  * Copyright (C) 2015 Samsung Electronics
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 &ppmu_dmc0 {
diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
index a67bd953d754..8e7a7fb98124 100644
--- a/arch/arm/boot/dts/exynos4412-prime.dtsi
+++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4412 Prime SoC device tree source
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /*
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index 7fcb43431b59..5c5c2887c14f 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4412 based SMDK board device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Device tree source file for Samsung's SMDK4412 board which is based on
  * Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4412.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index cec5bef44bdb..e4ad2fc0329e 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4412 SoC device tree source
  *
@@ -11,11 +12,7 @@
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4412 SoC. As device tree coverage for Exynos4412 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include "exynos4.dtsi"
 #include "exynos4412-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 1b1dd3850638..f8d7de1144f1 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5 SoC series common device tree source
  *
@@ -7,10 +8,6 @@
  * Samsung's Exynos5 SoC series device nodes are listed in this file. Particular
  * SoCs from Exynos5 series can include this file and provide values for SoCs
  * specfic bindings.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 0efd678b8251..7a8a5c55701a 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5250 based Arndale board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index 1fd122db18e6..6ff6dea29d44 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5250 SoC pin-mux and pin-config device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Samsung's Exynos5250 SoC pin-mux and pin-config optiosn are listed as device
  * tree nodes are listed in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/pinctrl/samsung.h>
 
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 1e3f9627766c..d5e66189ed2a 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG SMDK5250 board device tree source
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 2e7175d2b1b8..59cf1b202849 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Google Snow board device tree source
  *
  * Copyright (c) 2012 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/exynos5250-snow-rev5.dts b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
index 90560c316f64..0348b1c49a69 100644
--- a/arch/arm/boot/dts/exynos5250-snow-rev5.dts
+++ b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Google Snow Rev 5+ board device tree source
  *
  * Copyright (c) 2012 Google, Inc
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index df48f2cc96f7..4827cb506fa3 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Google Snow board device tree source
  *
  * Copyright (c) 2012 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 47dbc50546c1..3d501926c227 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Google Spring board device tree source
  *
  * Copyright (c) 2013 Google, Inc
  * Copyright (c) 2014 SUSE LINUX Products GmbH
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 571c89605a39..56626d1a4235 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5250 SoC device tree source
  *
@@ -11,11 +12,7 @@
  * Note: This file does not include device nodes for all the controllers in
  * EXYNOS5250 SoC. As device tree coverage for EXYNOS5250 increases,
  * additional nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/clock/exynos5250.h>
 #include "exynos5.dtsi"
diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
index 1b911a219a27..b1edb20b789e 100644
--- a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5260 SoC pin-mux and pin-config device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Samsung's Exynos5260 SoC pin-mux and pin-config options are listed as device
  * tree nodes are listed in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/pinctrl/samsung.h>
 
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 73b7cdd5f522..442eb0353f29 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG XYREF5260 board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5260.dtsi"
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 12c6b011576b..55167850619c 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5260 SoC device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/clock/exynos5260-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index a45eaae33f8f..a2046f5f998c 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  * Copyright (c) 2016 Krzysztof Kozlowski
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index ff46a1c27182..369a8a7f2105 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Exynos5410 SoC pin-mux and pin-config device tree source
  *
  * Copyright (c) 2013 Hardkernel Co., Ltd.
  *              http://www.hardkernel.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/pinctrl/samsung.h>
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 25f21e9e7d58..8fc8c841d34b 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG SMDK5410 board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5410.dtsi"
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 4e5d9bad085f..375b73015ee4 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5410 SoC device tree source
  *
@@ -7,10 +8,6 @@
  * SAMSUNG EXYNOS5410 SoC device nodes are listed in this file.
  * EXYNOS5410 based board files can include this file and provide
  * values for board specfic bindings.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos54xx.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index bc78575d8a4d..cdda614e417e 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5420 based Arndale Octa board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5420.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 4ee2f9718e8a..123f0cef658d 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5420 SoC cpu device tree source
  *
@@ -14,10 +15,6 @@
  * booting cluster (big or LITTLE) is chosen by IROM code by reading
  * the gpg2-1 GPIO. By default all Exynos5422 based boards choose booting
  * from the LITTLE: Cortex-A7.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 / {
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 38af8769711c..5a76ed77dda1 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Google Peach Pit Rev 6+ board device tree source
  *
  * Copyright (c) 2014 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index 65aa0e300c23..dda8ca2d2324 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5420 SoC pin-mux and pin-config device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Samsung's Exynos5420 SoC pin-mux and pin-config options are listed as device
  * tree nodes are listed in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/pinctrl/samsung.h>
 
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 310d8637ce9f..831c7336f237 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG SMDK5420 board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5420.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
index c8771c660550..fbc77cb58473 100644
--- a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
+++ b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos5420 TMU sensor configuration
  *
  * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
  * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <dt-bindings/thermal/thermal_exynos.h>
diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
index 2180a0152c9b..a67a380717ec 100644
--- a/arch/arm/boot/dts/exynos5420-trip-points.dtsi
+++ b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for default Exynos5420 thermal zone definition
  *
  * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 polling-delay-passive = <0>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 61b42b7c4fee..2f3cb2a97f71 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5420 SoC device tree source
  *
@@ -7,10 +8,6 @@
  * SAMSUNG EXYNOS54200 SoC device nodes are listed in this file.
  * EXYNOS5420 based board files can include this file and provide
  * values for board specfic bindings.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos54xx.dtsi"
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 73fb37d5042d..c593809c7f08 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5422 SoC cpu device tree source
  *
@@ -13,10 +14,6 @@
  * booting cluster (big or LITTLE) is chosen by IROM code by reading
  * the gpg2-1 GPIO. By default all Exynos5422 based boards choose booting
  * from the LITTLE: Cortex-A7.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 / {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 81cbb77204a8..d31249f25ccf 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -1,14 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU3/XU4/HC1 boards core device tree source
  *
  * Copyright (c) 2017 Marek Szyprowski
  * Copyright (c) 2013-2017 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/clock/samsung,s2mps11.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index fb8e8ae776e9..8f332be143f7 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -1,14 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid HC1 board device tree source
  *
  * Copyright (c) 2017 Marek Szyprowski
  * Copyright (c) 2017 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5422-odroid-core.dtsi"
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index fe4d8ef094d0..03611d50c5a9 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU3 audio subsystem device tree source
  *
@@ -5,11 +6,7 @@
  * Copyright (c) 2014 Collabora Ltd.
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/sound/samsung-i2s.h>
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 445c6c5a1300..96e281c0a118 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU3 board device tree source
  *
@@ -6,11 +7,7 @@
  * Copyright (c) 2014 Collabora Ltd.
  * Copyright (c) 2015 Lukasz Majewski <l.majewski@samsung.com>
  *                    Anand Moon <linux.amoon@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/input/input.h>
 #include "exynos5422-odroid-core.dtsi"
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index 03fa88c45426..0db935f2b836 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU3-Lite board device tree source
  *
@@ -5,11 +6,7 @@
  * Copyright (c) 2014 Collabora Ltd.
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 9ed6564acfb0..0322f281912c 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -1,14 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU3 board device tree source
  *
  * Copyright (c) 2014 Collabora Ltd.
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 0c2f1ef8a552..4a30cc849b00 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU4 board device tree source
  *
@@ -5,11 +6,7 @@
  * Copyright (c) 2014 Collabora Ltd.
  * Copyright (c) 2013-2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include <dt-bindings/sound/samsung-i2s.h>
diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
index ad6f533b3f40..c4b8392d1ae1 100644
--- a/arch/arm/boot/dts/exynos5440-sd5v1.dts
+++ b/arch/arm/boot/dts/exynos5440-sd5v1.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG SD5v1 board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5440.dtsi"
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index 7eafad333bdb..a33c4fc29ae5 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG SSDK5440 board device tree source
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos5440.dtsi"
diff --git a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
index 7b2fba0ae92b..0421c3d42905 100644
--- a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
+++ b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos5440 TMU sensor configuration
  *
  * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <dt-bindings/thermal/thermal_exynos.h>
diff --git a/arch/arm/boot/dts/exynos5440-trip-points.dtsi b/arch/arm/boot/dts/exynos5440-trip-points.dtsi
index 356e963edf11..a2b04fed7d0b 100644
--- a/arch/arm/boot/dts/exynos5440-trip-points.dtsi
+++ b/arch/arm/boot/dts/exynos5440-trip-points.dtsi
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for default Exynos5440 thermal zone definition
  *
  * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 polling-delay-passive = <0>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 3acf3f2d643e..fce9e26b5930 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5440 SoC device tree source
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/clock/exynos5440.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
index 0ed30206625c..56acd832f0b3 100644
--- a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
+++ b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hardkernel Odroid XU/XU3 LED device tree source
  *
@@ -5,11 +6,7 @@
  * Copyright (c) 2014 Collabora Ltd.
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 8f87ab1dd9e3..de26e5ee0d2d 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos54xx SoC series common device tree source
  *
@@ -8,10 +9,6 @@
  * Device nodes common for Samsung Exynos5410/5420/5422/5800. Specific
  * Exynos 54xx SoCs should include this file and customize it further
  * (e.g. with clocks).
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos5.dtsi"
-- 
2.7.4
