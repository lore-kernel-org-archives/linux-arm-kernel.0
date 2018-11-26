From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:09 +0100
Subject: [PATCH 07/16] ARM: dts: r8a7740, emev2,
 sh73a0: Include SoC name in DTSI
In-Reply-To: <cover.1543236456.git.horms+renesas@verge.net.au>
References: <cover.1543236456.git.horms+renesas@verge.net.au>
Message-ID: <4b6cc41011e3bbd705d11c5b8d08f31ba251f104.1543236456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the R-Mobile A1 (r8a7740), Emma Mobile EV2 (emev2) and
SH-Mobile AG5 (sh72a0) DTSI to include product name.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
[simon: squashed similar patches]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi   | 2 +-
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 arch/arm/boot/dts/sh73a0.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 373ea8720769..67d86012a85c 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the EMEV2 SoC
+ * Device Tree Source for the Emma Mobile EV2 SoC
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
  */
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 383cba68dbba..12ffe73bf2bc 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the r8a7740 SoC
+ * Device Tree Source for the R-Mobile A1 (R8A77400) SoC
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
  */
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index e8f0a07c4564..33836990b102 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the SH73A0 SoC
+ * Device Tree Source for the SH-Mobile AG5 (R8A73A00/SH73A0) SoC
  *
  * Copyright (C) 2012 Renesas Solutions Corp.
  */
-- 
2.11.0
