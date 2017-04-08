From: dev@lynxeye.de (Lucas Stach)
Date: Sat,  8 Apr 2017 16:36:01 +0200
Subject: [RFC PATCH 1/7] ARM: dts: imx6*-hummingboard2: fix formatting
In-Reply-To: <20170408143607.15928-1-dev@lynxeye.de>
References: <20170408143607.15928-1-dev@lynxeye.de>
Message-ID: <20170408143607.15928-2-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial formatting change.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index fc79751..4513e98 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -486,9 +486,9 @@
 };
 
 &pwm1 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&pinctrl_hummingboard2_pwm1>;
-        status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_pwm1>;
+	status = "okay";
 };
 
 &pwm3 {
@@ -538,9 +538,7 @@
 
 &usdhc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-		&pinctrl_hummingboard2_usdhc3
-	>;
+	pinctrl-0 = <&pinctrl_hummingboard2_usdhc3>;
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
-- 
2.9.3
