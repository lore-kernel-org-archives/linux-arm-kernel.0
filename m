From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 14 Jun 2015 19:54:05 +0930
Subject: [PATCHv6 4/4] ARM: dts: exynos5422-odroidxu3: Enable thermal-zones
In-Reply-To: <1434277445-5243-1-git-send-email-linux.amoon@gmail.com>
References: <1434277445-5243-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1434277445-5243-4-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include exynos5422-cpu-thermal.dtsi to enable thermal_zone support.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index b6570fc..1565667 100644
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
