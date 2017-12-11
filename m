From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:58:03 +0000
Subject: [PATCH 09/20] ARM: dts: imx6*-hummingboard2: fix formatting
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eORP1-0000Hm-Gk@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <dev@lynxeye.de>

Trivial formatting change.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 7e94548c0de7..ab809ee0c58c 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -482,9 +482,9 @@
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
@@ -534,9 +534,7 @@
 
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
2.7.4
