From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 10 Mar 2018 22:18:01 +0900
Subject: [PATCH] ARM: dts: uniphier: use proper SPDX-License-Identifier style
Message-ID: <1520687881-31399-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/process/license-rules.rst, move the SPDX
License Identifier to the very top of the file.  I used C++ comment
style not only for the SPDX line but for the entire block because
this seems Linus' preference [1].  I also dropped the parentheses to
follow the examples in that document.

[1] https://lkml.org/lkml/2017/11/25/133

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts       | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ld4.dtsi          | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ld6b.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pinctrl.dtsi      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4-ace.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4-ref.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4-sanji.dts    | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro4.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pro5.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts   | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts    | 14 ++++++--------
 arch/arm/boot/dts/uniphier-pxs2.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi | 14 ++++++--------
 arch/arm/boot/dts/uniphier-sld8-ref.dts      | 14 ++++++--------
 arch/arm/boot/dts/uniphier-sld8.dtsi         | 14 ++++++--------
 arch/arm/boot/dts/uniphier-support-card.dtsi | 14 ++++++--------
 17 files changed, 102 insertions(+), 136 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index a3afd0c..21407e1 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD4 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD4 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 0459e84..37950ad 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD4 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD4 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 9327f6b..a0a44a4 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD6b Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD6b Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-ld6b.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ld6b.dtsi b/arch/arm/boot/dts/uniphier-ld6b.dtsi
index 9a7b25c..4d07a94 100644
--- a/arch/arm/boot/dts/uniphier-ld6b.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld6b.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier LD6b SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier LD6b SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /*
  * LD6b consists of two silicon dies: D-chip and A-chip.
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index de481c3..0468d9a 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier SoCs default pinctrl settings
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier SoCs default pinctrl settings
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 &pinctrl {
 	pinctrl_aout: aout {
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index 92b5cbb..db1b089 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 Ace Board
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 Ace Board
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pro4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 629bc14..efb0849 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pro4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index 7c4326a..dac4d66 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 Sanji Board
- *
- * Copyright (C) 2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 Sanji Board
+//
+// Copyright (C) 2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pro4.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index f77d739..844124b 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro4 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro4 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index f291dd6..06c2cef 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Pro5 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Pro5 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 / {
 	compatible = "socionext,uniphier-pro5";
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index d09acb8..59608de 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs2 Gentil Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs2 Gentil Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pxs2.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index 6f13a25..4170676 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs2 Vodka Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs2 Vodka Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-pxs2.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 18f336e..c0a8207 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier PXs2 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier PXs2 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
index 7a1c29b..04e60c2 100644
--- a/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
+++ b/arch/arm/boot/dts/uniphier-ref-daughter.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Reference Daughter Board
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Reference Daughter Board
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 &i2c0 {
 	eeprom at 50 {
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index e052ea3..fe386fa 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier sLD8 Reference Board
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier sLD8 Reference Board
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 /dts-v1/;
 #include "uniphier-sld8.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index bc8c240..e9b9b4f 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier sLD8 SoC
- *
- * Copyright (C) 2015-2016 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier sLD8 SoC
+//
+// Copyright (C) 2015-2016 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
diff --git a/arch/arm/boot/dts/uniphier-support-card.dtsi b/arch/arm/boot/dts/uniphier-support-card.dtsi
index e4e7e1b..bf441c2 100644
--- a/arch/arm/boot/dts/uniphier-support-card.dtsi
+++ b/arch/arm/boot/dts/uniphier-support-card.dtsi
@@ -1,11 +1,9 @@
-/*
- * Device Tree Source for UniPhier Support Card (Expansion Board)
- *
- * Copyright (C) 2015-2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- */
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Device Tree Source for UniPhier Support Card (Expansion Board)
+//
+// Copyright (C) 2015-2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 &system_bus {
 	status = "okay";
-- 
2.7.4
