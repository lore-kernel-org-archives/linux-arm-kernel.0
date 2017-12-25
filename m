From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 25 Dec 2017 11:40:12 +0100
Subject: [PATCH 4/5] ARM: dts: s5pv210: Add SPDX license identifier
In-Reply-To: <1514198413-4358-1-git-send-email-krzk@kernel.org>
References: <1514198413-4358-1-git-send-email-krzk@kernel.org>
Message-ID: <1514198413-4358-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL v2.0 license with a SPDX license indentifier.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aquila.dts   | 5 +----
 arch/arm/boot/dts/s5pv210-goni.dts     | 5 +----
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 5 +----
 arch/arm/boot/dts/s5pv210-smdkc110.dts | 5 +----
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 5 +----
 arch/arm/boot/dts/s5pv210-torbreck.dts | 5 +----
 arch/arm/boot/dts/s5pv210.dtsi         | 7 ++-----
 7 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 40139923eef0..14969b6529e8 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S5PV210 SoC device tree source
  *
@@ -7,10 +8,6 @@
  * Tomasz Figa <t.figa@samsung.com>
  *
  * Board device tree source for Samsung Aquila board.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index c56f51ee7897..eb6d1926c0d6 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S5PV210 SoC device tree source
  *
@@ -7,10 +8,6 @@
  * Tomasz Figa <t.figa@samsung.com>
  *
  * Board device tree source for Samsung Goni board.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 9a3e851e2e22..3a79feab11c3 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S5PV210 SoC device tree source
  *
@@ -13,10 +14,6 @@
  * Note: This file does not include device nodes for all the controllers in
  * S5PV210 SoC. As device tree coverage for S5PV210 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <dt-bindings/pinctrl/samsung.h>
diff --git a/arch/arm/boot/dts/s5pv210-smdkc110.dts b/arch/arm/boot/dts/s5pv210-smdkc110.dts
index 5d14da911aa5..e5aec6c526fb 100644
--- a/arch/arm/boot/dts/s5pv210-smdkc110.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkc110.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S5PV210 SoC device tree source
  *
@@ -11,10 +12,6 @@
  * NOTE: This file is completely based on original board file for mach-smdkc110
  * available in Linux 3.15 and intends to provide equivalent level of hardware
  * support. Due to lack of hardware, _no_ testing has been performed.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index 75398318ed57..84b38f185199 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S5PV210 SoC device tree source
  *
@@ -11,10 +12,6 @@
  * NOTE: This file is completely based on original board file for mach-smdkv210
  * available in Linux 3.15 and intends to provide equivalent level of hardware
  * support. Due to lack of hardware, _no_ testing has been performed.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/s5pv210-torbreck.dts b/arch/arm/boot/dts/s5pv210-torbreck.dts
index 7cb50bcee888..cd25e72ccd84 100644
--- a/arch/arm/boot/dts/s5pv210-torbreck.dts
+++ b/arch/arm/boot/dts/s5pv210-torbreck.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S5PV210 SoC device tree source
  *
@@ -11,10 +12,6 @@
  * NOTE: This file is completely based on original board file for mach-torbreck
  * available in Linux 3.15 and intends to provide equivalent level of hardware
  * support. Due to lack of hardware, _no_ testing has been performed.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 726c5d0dbd5b..247c0029659c 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's S5PV210 SoC device tree source
  *
@@ -13,11 +14,7 @@
  * Note: This file does not include device nodes for all the controllers in
  * S5PV210 SoC. As device tree coverage for S5PV210 increases, additional
  * nodes can be added to this file.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #include <dt-bindings/clock/s5pv210.h>
 #include <dt-bindings/clock/s5pv210-audss.h>
-- 
2.7.4
