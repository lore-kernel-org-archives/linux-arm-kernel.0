From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 30 Dec 2016 13:14:19 +0900
Subject: [PATCH v2 2/4] pinctrl: dt-bindings: samsung: add drive strength
 macros for Exynos5433
In-Reply-To: <20161230041421.24448-1-andi.shyti@samsung.com>
References: <20161230041421.24448-1-andi.shyti@samsung.com>
 <CGME20161230041427epcas1p1e4d0dd5e7f9928664c664b7850dbd87a@epcas1p1.samsung.com>
Message-ID: <20161230041421.24448-3-andi.shyti@samsung.com>
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
 include/dt-bindings/pinctrl/samsung.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
index 6276eb785e2b..e0ebb20ffdd3 100644
--- a/include/dt-bindings/pinctrl/samsung.h
+++ b/include/dt-bindings/pinctrl/samsung.h
@@ -45,6 +45,20 @@
 #define EXYNOS5420_PIN_DRV_LV3		2
 #define EXYNOS5420_PIN_DRV_LV4		3
 
+/* Drive strengths for Exynos5433 */
+#define EXYNOS5433_PIN_DRV_FAST_SR1	0
+#define EXYNOS5433_PIN_DRV_FAST_SR2	1
+#define EXYNOS5433_PIN_DRV_FAST_SR3	2
+#define EXYNOS5433_PIN_DRV_FAST_SR4	3
+#define EXYNOS5433_PIN_DRV_FAST_SR5	4
+#define EXYNOS5433_PIN_DRV_FAST_SR6	5
+#define EXYNOS5433_PIN_DRV_SLOW_SR1	8
+#define EXYNOS5433_PIN_DRV_SLOW_SR2	9
+#define EXYNOS5433_PIN_DRV_SLOW_SR3	0xa
+#define EXYNOS5433_PIN_DRV_SLOW_SR4	0xb
+#define EXYNOS5433_PIN_DRV_SLOW_SR5	0xc
+#define EXYNOS5433_PIN_DRV_SLOW_SR6	0xf
+
 #define EXYNOS_PIN_FUNC_INPUT		0
 #define EXYNOS_PIN_FUNC_OUTPUT		1
 #define EXYNOS_PIN_FUNC_2		2
-- 
2.11.0
