From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 15 Jun 2015 12:23:23 +0930
Subject: [PATCHv7 4/4] ARM: dts: exynos5422-odroidxu3: Enable thermal-zones
In-Reply-To: <1434336803-4132-1-git-send-email-linux.amoon@gmail.com>
References: <1434336803-4132-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1434336803-4132-4-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include exynos5422-cpu-thermal.dtsi to enable thermal_zone support.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96d894e..2b65932 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5800.dtsi"
+#include "exynos5422-cpu-thermal.dtsi"
 
 / {
 	memory {
-- 
2.4.3
