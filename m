From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  9 Jan 2018 19:29:55 +0100
Subject: [PATCH 2/3] memory: samsung: Add SPDX license identifiers
In-Reply-To: <20180109182956.2456-1-krzk@kernel.org>
References: <20180109182956.2456-1-krzk@kernel.org>
Message-ID: <20180109182956.2456-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL license statements with SPDX GPL-2.0 license identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/Kconfig       |  1 +
 drivers/memory/samsung/Makefile      |  1 +
 drivers/memory/samsung/exynos-srom.c | 18 +++++++-----------
 drivers/memory/samsung/exynos-srom.h |  7 ++-----
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
index 9de12222061c..79ce7ea58903 100644
--- a/drivers/memory/samsung/Kconfig
+++ b/drivers/memory/samsung/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config SAMSUNG_MC
 	bool "Samsung Exynos Memory Controller support" if COMPILE_TEST
 	help
diff --git a/drivers/memory/samsung/Makefile b/drivers/memory/samsung/Makefile
index 9c554d5522ad..00587be66211 100644
--- a/drivers/memory/samsung/Makefile
+++ b/drivers/memory/samsung/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_EXYNOS_SROM)	+= exynos-srom.o
diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index bf827a666694..7edd7fb540f2 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -1,14 +1,10 @@
-/*
- * Copyright (c) 2015 Samsung Electronics Co., Ltd.
- *	      http://www.samsung.com/
- *
- * EXYNOS - SROM Controller support
- * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2015 Samsung Electronics Co., Ltd.
+//	      http://www.samsung.com/
+//
+// EXYNOS - SROM Controller support
+// Author: Pankaj Dubey <pankaj.dubey@samsung.com>
 
 #include <linux/io.h>
 #include <linux/init.h>
diff --git a/drivers/memory/samsung/exynos-srom.h b/drivers/memory/samsung/exynos-srom.h
index 34660c6a57a9..da612797f522 100644
--- a/drivers/memory/samsung/exynos-srom.h
+++ b/drivers/memory/samsung/exynos-srom.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Exynos SROMC register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 #ifndef __EXYNOS_SROM_H
 #define __EXYNOS_SROM_H __FILE__
-- 
2.11.0
