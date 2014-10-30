From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 12:20:52 +0100
Subject: [PATCH v3 13/14] ARM: dts: exynos5420-peach: Update to new max77802
 regulator compatible
In-Reply-To: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414668053-31370-14-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update to new bindings for max77802 regulator driver by adding proper
compatible field for regulators node.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 9a050e19a4dc..1bc25cd9b437 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -185,6 +185,8 @@
 		inl10-supply = <&buck7_reg>;
 
 		regulators {
+			compatible = "maxim,max77802-pmic";
+
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
 				regulator-min-microvolt = <800000>;
-- 
1.9.1
