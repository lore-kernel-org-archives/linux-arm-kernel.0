From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 29 Dec 2016 17:42:08 +0900
Subject: [PATCH 1/4] pinctrl: dt-bindings: samsung: add drive strength macros
 for Exynos5433
In-Reply-To: <20161229084211.20442-1-andi.shyti@samsung.com>
References: <20161229084211.20442-1-andi.shyti@samsung.com>
 <CGME20161229084221epcas5p43926b87dccbee0db4045faa5ddca565d@epcas5p4.samsung.com>
Message-ID: <20161229084211.20442-2-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5db7e3bb87df ("pinctrl: dt-bindings: samsung: Add header with
values used for configuration") has added a header file for defining the
pinctrl values in order to avoid hardcoded settings in the Exynos
DTS related files.

Extend samsung.h to the Exynos5433 for drive strength values
which are strictly related to the particular SoC and may defer
from others.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 include/dt-bindings/pinctrl/samsung.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
index 6276eb785e2b..58868313d64b 100644
--- a/include/dt-bindings/pinctrl/samsung.h
+++ b/include/dt-bindings/pinctrl/samsung.h
@@ -45,6 +45,12 @@
 #define EXYNOS5420_PIN_DRV_LV3		2
 #define EXYNOS5420_PIN_DRV_LV4		3
 
+/* Drive strengths for Exynos5433 */
+#define EXYNOS5433_PIN_DRV_LV1		0
+#define EXYNOS5433_PIN_DRV_LV2		1
+#define EXYNOS5433_PIN_DRV_LV3		2
+#define EXYNOS5433_PIN_DRV_LV4		3
+
 #define EXYNOS_PIN_FUNC_INPUT		0
 #define EXYNOS_PIN_FUNC_OUTPUT		1
 #define EXYNOS_PIN_FUNC_2		2
-- 
2.11.0
