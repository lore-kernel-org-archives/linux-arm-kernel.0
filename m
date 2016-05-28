From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 28 May 2016 11:54:29 +0200
Subject: [PATCH v5 18/22] dt-bindings: clock: Add I2C,
 HSI2C and RTC clock IDs to Exynos5410
In-Reply-To: <1464429273-23457-1-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
Message-ID: <1464429273-23457-19-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IDs for I2C, USI (HSI2C) and RTC clocks to Exynos5410. Use the same
number as for Exynos5420 just in case in future these drivers were
merged.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 include/dt-bindings/clock/exynos5410.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index 34c8e96987a1..e94b7bbfd6af 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -38,9 +38,18 @@
 #define CLK_UART0		257
 #define CLK_UART1		258
 #define CLK_UART2		259
+#define CLK_I2C0		261
+#define CLK_I2C1		262
+#define CLK_I2C2		263
+#define CLK_I2C3		264
+#define CLK_USI0		265
+#define CLK_USI1		266
+#define CLK_USI2		267
+#define CLK_USI3		268
 #define CLK_UART3		260
 #define CLK_PWM			279
 #define CLK_MCT			315
+#define CLK_RTC			317
 #define CLK_MMC0		351
 #define CLK_MMC1		352
 #define CLK_MMC2		353
-- 
2.7.4
