From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 20:39:05 +0200
Subject: [PATCH 6/6] ARM: dts: exynos: No need to enable TMU nodes on Odroid
 XU3 family
In-Reply-To: <1464719945-3417-1-git-send-email-krzk@kernel.org>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
Message-ID: <1464719945-3417-6-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal nodes are not disabled in exynos5420.dtsi so there is no
need to manually enable them on Odroid XU3/XU3-Lite/XU4 boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 20fa7612080d..c08392b9e0dd 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -388,27 +388,22 @@
 
 &tmu_cpu0 {
 	vtmu-supply = <&ldo7_reg>;
-	status = "okay";
 };
 
 &tmu_cpu1 {
 	vtmu-supply = <&ldo7_reg>;
-	status = "okay";
 };
 
 &tmu_cpu2 {
 	vtmu-supply = <&ldo7_reg>;
-	status = "okay";
 };
 
 &tmu_cpu3 {
 	vtmu-supply = <&ldo7_reg>;
-	status = "okay";
 };
 
 &tmu_gpu {
 	vtmu-supply = <&ldo7_reg>;
-	status = "okay";
 };
 
 &rtc {
-- 
2.7.4
