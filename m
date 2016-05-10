From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 22:09:05 +0200
Subject: [PATCH v3 02/27] dt-bindings: clock: Add PWM and USB clock IDs to
 Exynos5410
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <1462910970-1812-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IDs for PWM and USB clocks to Exynos5410. Use the same number as for
Exynos5420 just in case in future these drivers were merged.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 include/dt-bindings/clock/exynos5410.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/exynos5410.h b/include/dt-bindings/clock/exynos5410.h
index 213f19e02870..34c8e96987a1 100644
--- a/include/dt-bindings/clock/exynos5410.h
+++ b/include/dt-bindings/clock/exynos5410.h
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2016 Krzysztof Kozlowski
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -27,16 +28,25 @@
 #define CLK_SCLK_MMC0		132
 #define CLK_SCLK_MMC1		133
 #define CLK_SCLK_MMC2		134
+#define CLK_SCLK_USBD300	150
+#define CLK_SCLK_USBD301	151
+#define CLK_SCLK_USBPHY300	152
+#define CLK_SCLK_USBPHY301	153
+#define CLK_SCLK_PWM		155
 
 /* gate clocks */
 #define CLK_UART0		257
 #define CLK_UART1		258
 #define CLK_UART2		259
 #define CLK_UART3		260
+#define CLK_PWM			279
 #define CLK_MCT			315
 #define CLK_MMC0		351
 #define CLK_MMC1		352
 #define CLK_MMC2		353
+#define CLK_USBH20		365
+#define CLK_USBD300		366
+#define CLK_USBD301		367
 
 #define CLK_NR_CLKS		512
 
-- 
2.5.0
