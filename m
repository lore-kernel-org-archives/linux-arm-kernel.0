From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 01 Jun 2016 11:45:49 +0200
Subject: [PATCH 1/3] dt-bindings: clock: Add watchdog and SSS clock IDs to
 Exynos5410
Message-ID: <1464774351-23604-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IDs for watchdog and Security SubSystem to Exynos5410.  Use the same
number as for Exynos5420 just in case in future these drivers were
merged.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 include/dt-bindings/clock/exynos5410.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index 705b2aa84317..85b467b3a207 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -49,6 +49,7 @@
 #define CLK_UART3		260
 #define CLK_PWM			279
 #define CLK_MCT			315
+#define CLK_WDT			316
 #define CLK_RTC			317
 #define CLK_TMU			318
 #define CLK_MMC0		351
@@ -57,6 +58,7 @@
 #define CLK_USBH20		365
 #define CLK_USBD300		366
 #define CLK_USBD301		367
+#define CLK_SSS			471
 
 #define CLK_NR_CLKS		512
 
-- 
1.9.1
