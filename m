From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  3 May 2016 19:52:19 +0200
Subject: [RFC PATCH 02/12] dt-bindings: clock: Add PWM clock ID to Exynos5410
In-Reply-To: <1462297949-13824-1-git-send-email-krzk@kernel.org>
References: <1462297949-13824-1-git-send-email-krzk@kernel.org>
Message-ID: <1462297949-13824-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ID for PWM clock to Exynos5410. Use the same number as for
Exynos5420.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

A question: does it make sense to stick to same IDs?
---
 include/dt-bindings/clock/exynos5410.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index 213f19e02870..8d54ba7ff570 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2016 Krzysztof Kozlowski
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -33,6 +34,7 @@
 #define CLK_UART1		258
 #define CLK_UART2		259
 #define CLK_UART3		260
+#define CLK_PWM			279
 #define CLK_MCT			315
 #define CLK_MMC0		351
 #define CLK_MMC1		352
-- 
2.5.0
