From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 20 Dec 2017 20:27:02 +0100
Subject: [PATCH 2/2] arm64: dts: exynos: Fix typo in MSCL clock controller
 unit address
In-Reply-To: <20171220192702.32515-1-krzk@kernel.org>
References: <20171220192702.32515-1-krzk@kernel.org>
Message-ID: <20171220192702.32515-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo in unit address of MSCL clock controller (the reg entry is
correct).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 0ba5df825eff..3e8311c60d1b 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -468,7 +468,7 @@
 			clocks = <&xxti>, <&cmu_mif CLK_SCLK_BUS_PLL_ATLAS>;
 		};
 
-		cmu_mscl: clock-controller at 105d0000 {
+		cmu_mscl: clock-controller at 150d0000 {
 			compatible = "samsung,exynos5433-cmu-mscl";
 			reg = <0x150d0000 0x1000>;
 			#clock-cells = <1>;
-- 
2.11.0
