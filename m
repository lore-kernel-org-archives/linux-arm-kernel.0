From: s.shirish@samsung.com (Shirish S)
Date: Mon, 11 Feb 2013 05:01:28 -0500
Subject: [PATCH] ARM: dts: Correct the pin configuration for eMMC
Message-ID: <1360576888-19778-1-git-send-email-s.shirish@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects the pin function value of sd4_bus8 from 3
to 4.
This is verified on origen board for testing eMMC on
dw_mci controller.

Signed-off-by: Shirish S <s.shirish@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index 8e6115a..099cec7 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -661,7 +661,7 @@
 
 		sd4_bus8: sd4-bus-width8 {
 			samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
-			samsung,pin-function = <3>;
+			samsung,pin-function = <4>;
 			samsung,pin-pud = <4>;
 			samsung,pin-drv = <3>;
 		};
-- 
1.8.0
