From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 20:39:00 +0200
Subject: [PATCH 1/6] dt-bindings: clock: Add TMU clock ID to Exynos5410
Message-ID: <1464719945-3417-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ID for TMU clock to Exynos5410. Use the same number as for
Exynos5420 just in case in future these drivers were merged.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/dt-bindings/clock/exynos5410.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index e94b7bbfd6af..705b2aa84317 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -50,6 +50,7 @@
 #define CLK_PWM			279
 #define CLK_MCT			315
 #define CLK_RTC			317
+#define CLK_TMU			318
 #define CLK_MMC0		351
 #define CLK_MMC1		352
 #define CLK_MMC2		353
-- 
2.7.4
