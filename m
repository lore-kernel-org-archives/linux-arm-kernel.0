From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:22:09 +0200
Subject: [PATCH 2/7] ARM: dts: Include R-Car Gen2 product name in DTSI files
In-Reply-To: <cover.1538123642.git.horms+renesas@verge.net.au>
References: <cover.1538123642.git.horms+renesas@verge.net.au>
Message-ID: <89b43b08123f454f697f7ab02187f09b6e4a36b6.1538123642.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Improve the user friendliness of the DTS code base by including the
R-Car product name in each R-Car Gen2 DTSI file.

The product names are taken from:
Documentation/devicetree/bindings/arm/shmobile.txt

Signed-off-by: Magnus Damm <damm@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/r8a7792.dtsi | 2 +-
 arch/arm/boot/dts/r8a7793.dtsi | 2 +-
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 52a757f47bf0..5a2747758f67 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7790 SoC
+ * Device Tree Source for the R-Car H2 (R8A77900) SoC
  *
  * Copyright (C) 2015 Renesas Electronics Corporation
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 25b6a99dd87a..6f875502453c 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7791 SoC
+ * Device Tree Source for the R-Car M2-W (R8A77910) SoC
  *
  * Copyright (C) 2013-2015 Renesas Electronics Corporation
  * Copyright (C) 2013-2014 Renesas Solutions Corp.
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 52d16a260db0..8e9eb4b704d3 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7792 SoC
+ * Device Tree Source for the R-Car V2H (R8A77920) SoC
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
  */
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 620a570307ff..bf05110fac4e 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7793 SoC
+ * Device Tree Source for the R-Car M2-N (R8A77930) SoC
  *
  * Copyright (C) 2014-2015 Renesas Electronics Corporation
  */
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 886135a273cb..8d797d34816e 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7794 SoC
+ * Device Tree Source for the R-Car E2 (R8A77940) SoC
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright (C) 2014 Ulrich Hecht
-- 
2.11.0
