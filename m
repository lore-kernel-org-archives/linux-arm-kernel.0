From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 10 Apr 2015 01:14:19 +0930
Subject: [PATCH v2 5/5] ARM: dts: Enable thermal_zone for exynos5422.
In-Reply-To: <1428594259-3915-1-git-send-email-linux.amoon@gmail.com>
References: <1428594259-3915-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1428594259-3915-6-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include exynos5-cpu-thermal.dtsi to enable thermal_zone support.

Changes since v1 : Seperate the include previous patch.

Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 6e7ee53..16a5f10 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include "exynos5800.dtsi"
+#include "exynos5-cpu-thermal.dtsi"
 
 / {
 	model = "Hardkernel Odroid XU3";
-- 
1.9.1
