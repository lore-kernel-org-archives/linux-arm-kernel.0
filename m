From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 27 Sep 2018 19:03:47 +0200
Subject: [RESEND] dt-bindings: clock: samsung: Add SPDX license identifiers
Message-ID: <20180927170347.12909-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL license statements with SPDX license identifiers (GPL-2.0).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/exynos3250.h     | 5 +----
 include/dt-bindings/clock/exynos4.h        | 7 ++-----
 include/dt-bindings/clock/exynos5250.h     | 7 ++-----
 include/dt-bindings/clock/exynos5260-clk.h | 7 ++-----
 include/dt-bindings/clock/exynos5410.h     | 7 ++-----
 include/dt-bindings/clock/exynos5420.h     | 7 ++-----
 include/dt-bindings/clock/exynos5433.h     | 5 +----
 include/dt-bindings/clock/exynos7-clk.h    | 7 ++-----
 include/dt-bindings/clock/s3c2410.h        | 5 +----
 include/dt-bindings/clock/s3c2412.h        | 5 +----
 include/dt-bindings/clock/s3c2443.h        | 5 +----
 11 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/include/dt-bindings/clock/exynos3250.h b/include/dt-bindings/clock/exynos3250.h
index c796ff02ceeb..fe8214017b46 100644
--- a/include/dt-bindings/clock/exynos3250.h
+++ b/include/dt-bindings/clock/exynos3250.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * 	Author: Tomasz Figa <t.figa@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Samsung Exynos3250 clock controllers.
  */
 
diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
index f59ea85d77bd..a0439ce8e8d3 100644
--- a/include/dt-bindings/clock/exynos4.h
+++ b/include/dt-bindings/clock/exynos4.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  * Author: Andrzej Hajda <a.hajda@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos4 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_4_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_4_H
diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
index 15508adcdfde..bc8a3c53a54b 100644
--- a/include/dt-bindings/clock/exynos5250.h
+++ b/include/dt-bindings/clock/exynos5250.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  * Author: Andrzej Hajda <a.hajda@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos5250 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_5250_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_5250_H
diff --git a/include/dt-bindings/clock/exynos5260-clk.h b/include/dt-bindings/clock/exynos5260-clk.h
index a4bac9a1764f..98a58cbd81b2 100644
--- a/include/dt-bindings/clock/exynos5260-clk.h
+++ b/include/dt-bindings/clock/exynos5260-clk.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Rahul Sharma <rahul.sharma@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Provides Constants for Exynos5260 clocks.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLK_EXYNOS5260_H
 #define _DT_BINDINGS_CLK_EXYNOS5260_H
diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index 6cb4e90f81fc..f179eabbcdb7 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Copyright (c) 2016 Krzysztof Kozlowski
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos5421 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_5410_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_5410_H
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 2740ae0424a9..355f469943f1 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  * Author: Andrzej Hajda <a.hajda@samsung.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants for Exynos5420 clock controller.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS_5420_H
 #define _DT_BINDINGS_CLOCK_EXYNOS_5420_H
diff --git a/include/dt-bindings/clock/exynos5433.h b/include/dt-bindings/clock/exynos5433.h
index be39d23e6a32..98bd85ce1e45 100644
--- a/include/dt-bindings/clock/exynos5433.h
+++ b/include/dt-bindings/clock/exynos5433.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Chanwoo Choi <cw00.choi@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS5433_H
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 10c558611085..fce33c7050c8 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef _DT_BINDINGS_CLOCK_EXYNOS7_H
 #define _DT_BINDINGS_CLOCK_EXYNOS7_H
diff --git a/include/dt-bindings/clock/s3c2410.h b/include/dt-bindings/clock/s3c2410.h
index 352a7673fc69..0fb65c3f2f59 100644
--- a/include/dt-bindings/clock/s3c2410.h
+++ b/include/dt-bindings/clock/s3c2410.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clock controllers of Samsung S3C2410 and later.
  */
 
diff --git a/include/dt-bindings/clock/s3c2412.h b/include/dt-bindings/clock/s3c2412.h
index aac1dcfda81c..b4656156cc0f 100644
--- a/include/dt-bindings/clock/s3c2412.h
+++ b/include/dt-bindings/clock/s3c2412.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clock controllers of Samsung S3C2412.
  */
 
diff --git a/include/dt-bindings/clock/s3c2443.h b/include/dt-bindings/clock/s3c2443.h
index f3ba68a25ecb..a9d2f105d536 100644
--- a/include/dt-bindings/clock/s3c2443.h
+++ b/include/dt-bindings/clock/s3c2443.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clock controllers of Samsung S3C2443 and later.
  */
 
-- 
2.17.1
