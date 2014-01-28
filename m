From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Jan 2014 13:18:27 +0100
Subject: [PATCH 03/18] mfd: max14577: Remove not needed header inclusion
In-Reply-To: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1390911522-28209-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove not needed max14577-private.h header inclusion in the main driver
header. Remove obvious comment.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/mfd/max14577.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/mfd/max14577.h b/include/linux/mfd/max14577.h
index 247b021dfaaf..736d39c3ec0d 100644
--- a/include/linux/mfd/max14577.h
+++ b/include/linux/mfd/max14577.h
@@ -25,13 +25,8 @@
 #ifndef __MAX14577_H__
 #define __MAX14577_H__
 
-#include <linux/mfd/max14577-private.h>
 #include <linux/regulator/consumer.h>
 
-/*
- * MAX14577 Regulator
- */
-
 /* MAX14577 regulator IDs */
 enum max14577_regulators {
 	MAX14577_SAFEOUT = 0,
-- 
1.7.9.5
