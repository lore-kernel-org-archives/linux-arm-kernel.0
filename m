From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 08 Apr 2015 01:33:38 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: add act8846 supplies on rk3288-firefly
Message-ID: <1464569.rLOrpbGREu@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We defined bindings for the supply handling of act8846 regulators now, so
describe those on the firefly too.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index b54dd78..a3b1fc4 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -246,6 +246,14 @@
 		pinctrl-0 = <&pmic_vsel>, <&pwr_hold>;
 		system-power-controller;
 
+		vp1-supply = <&vcc_sys>;
+		vp2-supply = <&vcc_sys>;
+		vp3-supply = <&vcc_sys>;
+		vp4-supply = <&vcc_sys>;
+		inl1-supply = <&vcc_sys>;
+		inl2-supply = <&vcc_sys>;
+		inl3-supply = <&vcc_20>;
+
 		regulators {
 			vcc_ddr: REG1 {
 				regulator-name = "vcc_ddr";
-- 
2.1.4
