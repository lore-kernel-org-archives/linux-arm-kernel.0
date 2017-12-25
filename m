From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 25 Dec 2017 21:17:59 +0100
Subject: [PATCH] soc: samsung: Add SPDX license identifier
Message-ID: <1514233079-6863-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL license statements with a SPDX GPL-2.0 license identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/samsung/Kconfig          |  1 +
 drivers/soc/samsung/Makefile         |  1 +
 drivers/soc/samsung/exynos-pmu.c     | 16 ++++++----------
 drivers/soc/samsung/exynos-pmu.h     |  5 +----
 drivers/soc/samsung/exynos3250-pmu.c | 16 ++++++----------
 drivers/soc/samsung/exynos4-pmu.c    | 16 ++++++----------
 drivers/soc/samsung/exynos5250-pmu.c | 16 ++++++----------
 drivers/soc/samsung/exynos5420-pmu.c | 16 ++++++----------
 drivers/soc/samsung/pm_domains.c     | 24 ++++++++++--------------
 9 files changed, 43 insertions(+), 68 deletions(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 8b25bd55e648..2186285fda92 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # SAMSUNG SoC drivers
 #
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 4d7694a4e7a4..29f294baac6e 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 938f8ccfcb74..f56adbd9fb8b 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -1,13 +1,9 @@
-/*
- * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS - CPU PMU(Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// EXYNOS - CPU PMU(Power Management Unit) support
 
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index 86b3f2f8966d..977e4daf5a0f 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Header for EXYNOS PMU Driver support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __EXYNOS_PMU_H
diff --git a/drivers/soc/samsung/exynos3250-pmu.c b/drivers/soc/samsung/exynos3250-pmu.c
index af2f54e14b83..275d348ed9c9 100644
--- a/drivers/soc/samsung/exynos3250-pmu.c
+++ b/drivers/soc/samsung/exynos3250-pmu.c
@@ -1,13 +1,9 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS3250 - CPU PMU (Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// EXYNOS3250 - CPU PMU (Power Management Unit) support
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
index 5dbfe4e31f4c..a7cdbf1aac0c 100644
--- a/drivers/soc/samsung/exynos4-pmu.c
+++ b/drivers/soc/samsung/exynos4-pmu.c
@@ -1,13 +1,9 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS4 - CPU PMU(Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// EXYNOS4 - CPU PMU(Power Management Unit) support
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
diff --git a/drivers/soc/samsung/exynos5250-pmu.c b/drivers/soc/samsung/exynos5250-pmu.c
index 8d94f0819f32..19b38e008145 100644
--- a/drivers/soc/samsung/exynos5250-pmu.c
+++ b/drivers/soc/samsung/exynos5250-pmu.c
@@ -1,13 +1,9 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS5250 - CPU PMU (Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// EXYNOS5250 - CPU PMU (Power Management Unit) support
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
diff --git a/drivers/soc/samsung/exynos5420-pmu.c b/drivers/soc/samsung/exynos5420-pmu.c
index 0a89fa79c678..b236d3b47b49 100644
--- a/drivers/soc/samsung/exynos5420-pmu.c
+++ b/drivers/soc/samsung/exynos5420-pmu.c
@@ -1,13 +1,9 @@
-/*
- * Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS5420 - CPU PMU (Power Management Unit) support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2011-2015 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com/
+//
+// EXYNOS5420 - CPU PMU (Power Management Unit) support
 
 #include <linux/pm.h>
 #include <linux/soc/samsung/exynos-regs-pmu.h>
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 7c4fec1f93b5..b6a436594a19 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -1,17 +1,13 @@
-/*
- * Exynos Generic power domain support.
- *
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Implementation of Exynos specific power domain control which is used in
- * conjunction with runtime-pm. Support for both device-tree and non-device-tree
- * based power domain support is included.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+// SPDX-License-Identifier: GPL-2.0
+//
+// Exynos Generic power domain support.
+//
+// Copyright (c) 2012 Samsung Electronics Co., Ltd.
+//		http://www.samsung.com
+//
+// Implementation of Exynos specific power domain control which is used in
+// conjunction with runtime-pm. Support for both device-tree and non-device-tree
+// based power domain support is included.
 
 #include <linux/io.h>
 #include <linux/err.h>
-- 
2.7.4
