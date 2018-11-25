From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 25 Nov 2018 18:02:44 -0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-wandboard: Switch to SPDX identifier
Message-ID: <1543176165-26733-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adopt the SPDX license identifier headers to ease license compliance
management. 

Most of the wandboard dts files have already been converted, so switch
the remaining ones.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi | 15 +++++----------
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi | 15 +++++----------
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi | 15 +++++----------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
index 855dc6f..e781a45 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -1,13 +1,8 @@
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- *
- * Author: Fabio Estevam <fabio.estevam@freescale.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2013 Freescale Semiconductor, Inc.
+//
+// Author: Fabio Estevam <fabio.estevam@freescale.com>
 
 #include "imx6qdl-wandboard.dtsi"
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
index 49a0a55..3874e74 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
@@ -1,13 +1,8 @@
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- *
- * Author: Fabio Estevam <fabio.estevam@freescale.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2013 Freescale Semiconductor, Inc.
+//
+// Author: Fabio Estevam <fabio.estevam@freescale.com>
 
 #include "imx6qdl-wandboard.dtsi"
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
index 69d9c86..9390979 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
@@ -1,13 +1,8 @@
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- *
- * Author: Fabio Estevam <fabio.estevam@freescale.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2013 Freescale Semiconductor, Inc.
+//
+// Author: Fabio Estevam <fabio.estevam@freescale.com>
 
 #include "imx6qdl-wandboard.dtsi"
 
-- 
2.7.4
