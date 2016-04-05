From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 05 Apr 2016 11:04:28 +0900
Subject: [PATCH] hwrng: exynos - Fix misspelled Samsung address
Message-ID: <1459821868-26034-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct smasung.com into samsung.com.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/char/hw_random/exynos-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/exynos-rng.c b/drivers/char/hw_random/exynos-rng.c
index ada081232528..3443fdda44fa 100644
--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -2,7 +2,7 @@
  * exynos-rng.c - Random Number Generator driver for the exynos
  *
  * Copyright (C) 2012 Samsung Electronics
- * Jonghwa Lee <jonghwa3.lee@smasung.com>
+ * Jonghwa Lee <jonghwa3.lee@samsung.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
-- 
2.5.0
