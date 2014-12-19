From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 19 Dec 2014 19:03:20 +0530
Subject: [PATCH] arm64: dts: exynos7: Fix wrong base address of i2c7 bus
Message-ID: <1418996000-15735-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C7 base address corrected.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index db7058a..84a57c8 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -386,9 +386,9 @@
 			status = "disabled";
 		};
 
-		hsi2c_7: hsi2c at 13e10000 {
+		hsi2c_7: hsi2c at 14e10000 {
 			compatible = "samsung,exynos7-hsi2c";
-			reg = <0x13e10000 0x1000>;
+			reg = <0x14e10000 0x1000>;
 			interrupts = <0 462 0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.4.4
