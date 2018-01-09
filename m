From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  9 Jan 2018 19:29:56 +0100
Subject: [PATCH 3/3] soc: samsung: Add SPDX license identifiers to headers
In-Reply-To: <20180109182956.2456-1-krzk@kernel.org>
References: <20180109182956.2456-1-krzk@kernel.org>
Message-ID: <20180109182956.2456-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace GPL license statements with SPDX GPL-2.0 license identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/soc/samsung/exynos-pmu.h      | 5 +----
 include/linux/soc/samsung/exynos-regs-pmu.h | 6 +-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index e57eb4b6cc5a..fc0b445bb36b 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Header for EXYNOS PMU Driver support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __LINUX_SOC_EXYNOS_PMU_H
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index bebdde5dccd6..66dcb9ec273a 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -1,14 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010-2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * EXYNOS - Power management unit definition
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *
  * Notice:
  * This is not a list of all Exynos Power Management Unit SFRs.
  * There are too many of them, not mentioning subtle differences
-- 
2.11.0
