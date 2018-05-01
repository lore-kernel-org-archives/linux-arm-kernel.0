From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  1 May 2018 12:47:29 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-wandboard: Switch to SPDX identifier
Message-ID: <1525189650-5826-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts | 6 +-----
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts | 6 +-----
 arch/arm/boot/dts/imx6dl-wandboard.dts       | 6 +-----
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts  | 6 +-----
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts  | 6 +-----
 arch/arm/boot/dts/imx6q-wandboard.dts        | 6 +-----
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi     | 6 +-----
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts | 6 +-----
 8 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts b/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
index 5727fa4..738db4f 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
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
diff --git a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
index a72c07d..51de6b4 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
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
diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index a09f274..b43454d 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
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
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revb1.dts b/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
index b763352..be85b98 100644
--- a/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard-revb1.dts
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
diff --git a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
index 8691fab..fcfba28 100644
--- a/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard-revd1.dts
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
diff --git a/arch/arm/boot/dts/imx6q-wandboard.dts b/arch/arm/boot/dts/imx6q-wandboard.dts
index 2a3d98c..fa36fe18 100644
--- a/arch/arm/boot/dts/imx6q-wandboard.dts
+++ b/arch/arm/boot/dts/imx6q-wandboard.dts
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
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 6b0a86f..e1afa54 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
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
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
index 907ba0c..bcca5ac 100644
--- a/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
+++ b/arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
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
 #include "imx6qp.dtsi"
-- 
2.7.4
