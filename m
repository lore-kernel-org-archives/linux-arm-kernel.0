From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  1 May 2018 12:47:30 -0300
Subject: [PATCH 2/2] ARM: dts: imx6qdl-udoo: Switch to SPDX identifier
In-Reply-To: <1525189650-5826-1-git-send-email-festevam@gmail.com>
References: <1525189650-5826-1-git-send-email-festevam@gmail.com>
Message-ID: <1525189650-5826-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl-udoo.dts   | 6 +-----
 arch/arm/boot/dts/imx6q-udoo.dts    | 6 +-----
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 6 +-----
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-udoo.dts b/arch/arm/boot/dts/imx6dl-udoo.dts
index e3713f0..d871cac 100644
--- a/arch/arm/boot/dts/imx6dl-udoo.dts
+++ b/arch/arm/boot/dts/imx6dl-udoo.dts
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2013 Freescale Semiconductor, Inc.
  *
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 /dts-v1/;
 #include "imx6dl.dtsi"
diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/imx6q-udoo.dts
index c3e64ff..52e9f4a 100644
--- a/arch/arm/boot/dts/imx6q-udoo.dts
+++ b/arch/arm/boot/dts/imx6q-udoo.dts
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2013 Freescale Semiconductor, Inc.
  *
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 /dts-v1/;
 #include "imx6q.dtsi"
diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 9063879..4f27861 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2013 Freescale Semiconductor, Inc.
  *
  * Author: Fabio Estevam <fabio.estevam@freescale.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 / {
-- 
2.7.4
