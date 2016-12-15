From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 15 Dec 2016 15:03:23 +0100
Subject: [PATCH 1/2] media: s5p-cec: Remove unneeded linux/miscdevice.h include
Message-ID: <20161215140324.28986-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s5p-cec: does not use any miscdevice so this patch remove this
unnecessary inclusion.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/staging/media/s5p-cec/exynos_hdmi_cec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/s5p-cec/exynos_hdmi_cec.h b/drivers/staging/media/s5p-cec/exynos_hdmi_cec.h
index 3e4fc7b..7d94535 100644
--- a/drivers/staging/media/s5p-cec/exynos_hdmi_cec.h
+++ b/drivers/staging/media/s5p-cec/exynos_hdmi_cec.h
@@ -14,7 +14,6 @@
 #define _EXYNOS_HDMI_CEC_H_ __FILE__
 
 #include <linux/regmap.h>
-#include <linux/miscdevice.h>
 #include "s5p_cec.h"
 
 void s5p_cec_set_divider(struct s5p_cec_dev *cec);
-- 
2.10.2
