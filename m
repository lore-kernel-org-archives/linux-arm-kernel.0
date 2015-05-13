From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 16:07:00 +0930
Subject: [PATCHv5 5/5] ARM: dts: Enable thermal_zone for exynos5422-odroidxu3
In-Reply-To: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
References: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1431499020-3912-6-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include exynos5-cpu-thermal.dtsi to enable thermal_zone support.

Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index cd78816..9256fb5 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -13,6 +13,7 @@
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
 #include "exynos5800.dtsi"
+#include "exynos5-cpu-thermal.dtsi"
 
 / {
 	model = "Hardkernel Odroid XU3";
-- 
1.9.1
