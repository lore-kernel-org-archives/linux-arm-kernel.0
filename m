From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Jan 2018 22:18:17 +0100
Subject: [PATCH v2 2/4] ARM: dts: exynos: Remove duplicated inclusion of
 syscon restart nodes on Exynos5410
In-Reply-To: <20180130211819.17139-1-krzk@kernel.org>
References: <20180130211819.17139-1-krzk@kernel.org>
Message-ID: <20180130211819.17139-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos-syscon-restart.dtsi is already included by exynos5.dtsi
(through exynos54xx.dtsi).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 1886aa00b2db..1e6b57d013c4 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -11,7 +11,6 @@
  */
 
 #include "exynos54xx.dtsi"
-#include "exynos-syscon-restart.dtsi"
 #include <dt-bindings/clock/exynos5410.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.11.0
