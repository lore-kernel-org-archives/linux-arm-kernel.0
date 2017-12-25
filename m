From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 25 Dec 2017 11:40:13 +0100
Subject: [PATCH 5/5] arm64: dts: exynos: Add SPDX license identifier
In-Reply-To: <1514198413-4358-1-git-send-email-krzk@kernel.org>
References: <1514198413-4358-1-git-send-email-krzk@kernel.org>
Message-ID: <1514198413-4358-5-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL v2.0 license with a SPDX license indentifier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi                 | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi             | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi          | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts                  | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts                 | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi     | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi                 | 5 +----
 arch/arm64/boot/dts/exynos/exynos5433.dtsi                     | 5 +----
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts                | 7 ++-----
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi                | 7 ++-----
 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi        | 6 +-----
 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi            | 6 +-----
 arch/arm64/boot/dts/exynos/exynos7.dtsi                        | 5 +----
 14 files changed, 16 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
index ec11343dc528..d77b88af9582 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5433 SoC Memory interface and AMBA bus device tree source
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  * Chanwoo Choi <cw00.choi@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 &soc {
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
index 50403700274b..9df7c65593a1 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5433 SoC pin-mux and pin-config device tree source
  *
@@ -6,10 +7,6 @@
  *
  * Samsung's Exynos5433 SoC pin-mux and pin-config options are listed as device
  * tree nodes are listed in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/pinctrl/samsung.h>
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 2e4bc94e9b8b..a77462da4a36 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG Exynos5433 TM2 board device tree source
  *
@@ -5,10 +6,6 @@
  *
  * Common device tree source file for Samsung's TM2 and TM2E boards
  * which are based on Samsung Exynos5433 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index 23191eb9397c..3d7e0a782243 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG Exynos5433 TM2 board device tree source
  *
@@ -5,10 +6,6 @@
  *
  * Device tree source file for Samsung's TM2 board which is based on
  * Samsung Exynos5433 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos5433-tm2-common.dtsi"
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index b73e1231a86f..1e207ce8b97b 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG Exynos5433 TM2E board device tree source
  *
@@ -5,10 +6,6 @@
  *
  * Device tree source file for Samsung's TM2E(TM2 EDGE) board which is based on
  * Samsung Exynos5433 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos5433-tm2-common.dtsi"
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
index 9be2978f1b9a..f0803575fd9f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos5433 TMU sensor configuration
  *
  * Copyright (c) 2016 Jonghwa Lee <jonghwa3.lee@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/thermal/thermal_exynos.h>
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
index 125fe58d77ce..cccae662228a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos5433 TMU sensor configuration
  *
  * Copyright (c) 2016 Chanwoo Choi <cw00.choi@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/thermal/thermal_exynos.h>
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
index ceaa05145b8a..fe3a0b14bee6 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos5433 thermal zone
  *
  * Copyright (c) 2016 Chanwoo Choi <cw00.choi@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 1962b8074349..ebe97aa40546 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos5433 SoC device tree source
  *
@@ -10,10 +11,6 @@
  * Note: This file does not include device nodes for all the controllers in
  * Exynos5433 SoC. As device tree coverage for Exynos5433 increases,
  * additional nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/clock/exynos5433.h>
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 4a8b1fb51243..22723527e626 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG Exynos7 Espresso board device tree source
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos7.dtsi"
diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
index 8f58850cd28c..472dd649aa7e 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos7 SoC pin-mux and pin-config device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Samsung's Exynos7 SoC pin-mux and pin-config options are listed as
  * device tree nodes in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/pinctrl/samsung.h>
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
index 1d6dcf2aadba..48494710b7b2 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos7 TMU sensor configuration
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <dt-bindings/thermal/thermal_exynos.h>
diff --git a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
index 062358355a53..d3301b8bd364 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for default Exynos7 thermal zone definition
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 trips {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 9a3fbed1765a..6271a04645b2 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS7 SoC device tree source
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/clock/exynos7-clk.h>
-- 
2.7.4
