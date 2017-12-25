From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 25 Dec 2017 11:40:11 +0100
Subject: [PATCH 3/5] ARM: dts: s3c64xx: Add SPDX license identifier
In-Reply-To: <1514198413-4358-1-git-send-email-krzk@kernel.org>
References: <1514198413-4358-1-git-send-email-krzk@kernel.org>
Message-ID: <1514198413-4358-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL v2.0 license with a SPDX license indentifier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c6400.dtsi         | 7 ++-----
 arch/arm/boot/dts/s3c6410-mini6410.dts | 7 ++-----
 arch/arm/boot/dts/s3c6410-smdk6410.dts | 7 ++-----
 arch/arm/boot/dts/s3c6410.dtsi         | 7 ++-----
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi | 5 +----
 arch/arm/boot/dts/s3c64xx.dtsi         | 5 +----
 6 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/s3c6400.dtsi
index a7d1c8ec150d..8c28e8a0c824 100644
--- a/arch/arm/boot/dts/s3c6400.dtsi
+++ b/arch/arm/boot/dts/s3c6400.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S3C6400 SoC device tree source
  *
@@ -10,11 +11,7 @@
  * Note: This file does not include device nodes for all the controllers in
  * S3C6400 SoC. As device tree coverage for S3C6400 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include "s3c64xx.dtsi"
 
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index f4afda3594f8..f68601bd9c91 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S3C6410 based Mini6410 board device tree source
  *
@@ -5,11 +6,7 @@
  *
  * Device tree source file for FriendlyARM Mini6410 board which is based on
  * Samsung's S3C6410 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/s3c6410-smdk6410.dts
index ecf35ec466f7..b6b5afcd7602 100644
--- a/arch/arm/boot/dts/s3c6410-smdk6410.dts
+++ b/arch/arm/boot/dts/s3c6410-smdk6410.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung S3C6410 based SMDK6410 board device tree source.
  *
@@ -5,11 +6,7 @@
  *
  * Device tree source file for SAMSUNG SMDK6410 board which is based on
  * Samsung's S3C6410 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/s3c6410.dtsi b/arch/arm/boot/dts/s3c6410.dtsi
index eb4226b3407c..a766d6de696c 100644
--- a/arch/arm/boot/dts/s3c6410.dtsi
+++ b/arch/arm/boot/dts/s3c6410.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S3C6410 SoC device tree source
  *
@@ -10,11 +11,7 @@
  * Note: This file does not include device nodes for all the controllers in
  * S3C6410 SoC. As device tree coverage for S3C6410 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include "s3c64xx.dtsi"
 
diff --git a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
index 4e8e802b4ee1..8e9594d64b57 100644
--- a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S3C64xx SoC series common device tree source
  * - pin control-related definitions
@@ -6,10 +7,6 @@
  *
  * Samsung's S3C64xx SoCs pin banks, pin-mux and pin-config options are
  * listed as device tree nodes in this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/pinctrl/samsung.h>
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index c55cbb3af2c0..e2be3fbdd3f3 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S3C64xx SoC series common device tree source
  *
@@ -10,10 +11,6 @@
  * Note: This file does not include device nodes for all the controllers in
  * S3C64xx SoCs. As device tree coverage for S3C64xx increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "skeleton.dtsi"
-- 
2.7.4
