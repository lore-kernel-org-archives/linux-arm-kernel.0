From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed,  6 Jul 2016 01:58:57 +0530
Subject: [PATCH] arm64: dts: exynos: Modify the voltage range for BUCK2 for
 exynos7
Message-ID: <1467750537-13911-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the BUCK2 (vdd_atlas) voltage range to '500 - 1200mv' since
CPU DVFS requires it.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index d8767b0..299f3ce 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -249,7 +249,7 @@
 
 			buck2_reg: BUCK2 {
 				regulator-name = "vdd_atlas";
-				regulator-min-microvolt = <1200000>;
+				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
 				regulator-boot-on;
-- 
1.9.1
