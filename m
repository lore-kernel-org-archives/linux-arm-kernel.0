From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 21 Jan 2018 17:39:42 +0100
Subject: [PATCH] ARM: dts: owl: Convert to new-style SPDX license identifiers
Message-ID: <20180121163943.27330-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the SPDX-License-Identifier lines to the top.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/owl-s500-cubieboard6.dts     | 3 +--
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts | 3 +--
 arch/arm/boot/dts/owl-s500-guitar.dtsi         | 3 +--
 arch/arm/boot/dts/owl-s500-sparky.dts          | 3 +--
 arch/arm/boot/dts/owl-s500.dtsi                | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
index 396c55622fbd..0196523007d9 100644
--- a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Cubietech CubieBoard6
  *
  * Copyright (c) 2017 Andreas F?rber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
index abd9ba1f9e5d..89f14abf75e9 100644
--- a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2016-2017 Andreas F?rber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/owl-s500-guitar.dtsi b/arch/arm/boot/dts/owl-s500-guitar.dtsi
index 079b2c02cc13..81cc39871f17 100644
--- a/arch/arm/boot/dts/owl-s500-guitar.dtsi
+++ b/arch/arm/boot/dts/owl-s500-guitar.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * LeMaker Guitar SoM
  *
  * Copyright (c) 2016-2017 Andreas F?rber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include "owl-s500.dtsi"
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/owl-s500-sparky.dts
index 9e1a3ad29575..e2c7a699e152 100644
--- a/arch/arm/boot/dts/owl-s500-sparky.dts
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Allo.com Sparky
  *
  * Copyright (c) 2017 Andreas F?rber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 007c8d86d247..70ca1eaba8ed 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Actions Semi S500 SoC
  *
  * Copyright (c) 2016-2017 Andreas F?rber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.13.6
