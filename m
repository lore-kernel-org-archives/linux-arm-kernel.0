From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:57 +0200
Subject: [PATCH 02/58] arm64: dts: renesas: Include R-Car product name in DTSI
 files
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <e18a31a7add2d85c0d3e88460a09032d35e70d6c.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Browsing the DTS for all the R-Car SoCs with similar part numbers
makes my head hurt, so to improve the user friendliness of the
DTS code base include R-Car product name in each DTSI file.

Product names are derived from
Documentation/devicetree/bindings/arm/shmobile.txt

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi     | 2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi    | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
index 7b2fbaec9aef..d915cff5b1b0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7795 ES1.x SoC
+ * Device Tree Source for the R-Car H3 (R8A77950) ES1.x SoC
  *
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fb9d08ad7659..aa0d4c8f6b04 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7795 SoC
+ * Device Tree Source for the R-Car H3 (R8A77950) SoC
  *
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index cbd35c00b4af..b93596c9c6b1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7796 SoC
+ * Device Tree Source for the R-Car M3-W (R8A77960) SoC
  *
  * Copyright (C) 2016-2017 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 0cd44461a0bd..9c4f40589cbd 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a77965 SoC
+ * Device Tree Source for the R-Car M3-N (R8A77965) SoC
  *
  * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
  *
diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 954168858fed..18d1aafe2e30 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a77970 SoC
+ * Device Tree Source for the R-Car V3M (R8A77970) SoC
  *
  * Copyright (C) 2016-2017 Renesas Electronics Corp.
  * Copyright (C) 2017 Cogent Embedded, Inc.
diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 4a1097e32551..d3532fd4c94a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a77980 SoC
+ * Device Tree Source for the R-Car V3H (R8A77980) SoC
  *
  * Copyright (C) 2018 Renesas Electronics Corp.
  * Copyright (C) 2018 Cogent Embedded, Inc.
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index ae89260baad9..2c8f1194e6b5 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Device Tree Source for the r8a77990 SoC
+ * Device Tree Source for the R-Car E3 (R8A77990) SoC
  *
  * Copyright (C) 2018 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index fe77bc43c447..c94513ce5b9b 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a77995 SoC
+ * Device Tree Source for the R-Car D3 (R8A77995) SoC
  *
  * Copyright (C) 2016 Renesas Electronics Corp.
  * Copyright (C) 2017 Glider bvba
-- 
2.11.0
