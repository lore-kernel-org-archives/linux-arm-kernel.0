From: jagan@openedev.com (Jagan Teki)
Date: Sun, 15 Jan 2017 22:50:12 +0100
Subject: [PATCH 2/2] ARM: dts: imx6qdl: Fix "ERROR: code indent should use
 tabs where possible"
In-Reply-To: <1484517012-13321-1-git-send-email-jagan@openedev.com>
References: <1484517012-13321-1-git-send-email-jagan@openedev.com>
Message-ID: <1484517012-13321-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Fixed code indent tabs in respetcive imx6qdl dtsi files and
also add space on imx6qdl-icore-rqs.dtsi on usdhc bus-width nodes.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index b6078b1..91991d6 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -235,7 +235,7 @@
 
 			/* VDD_1P8 (1+R1/R2 = 2.505): GPS/VideoIn/ENET-PHY */
 			reg_1p8v: sw2 {
-                                regulator-name = "vdd1p8";
+				regulator-name = "vdd1p8";
 				regulator-min-microvolt = <1033310>;
 				regulator-max-microvolt = <2004000>;
 				lltc,fb-voltage-divider = <301000 200000>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 19cf036..a208e7e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -227,7 +227,7 @@
 
 			/* VDD_1P8 (1+R1/R2 = 2.505): GPS/VideoIn/ENET-PHY */
 			reg_1p8v: sw2 {
-                                regulator-name = "vdd1p8";
+				regulator-name = "vdd1p8";
 				regulator-min-microvolt = <1033310>;
 				regulator-max-microvolt = <2004000>;
 				lltc,fb-voltage-divider = <301000 200000>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 90200fa..67613dd 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -162,7 +162,7 @@
 
 			/* VDD_1P8 (1+R1/R2 = 2.505): ENET-PHY */
 			reg_1p8v: sw2 {
-                                regulator-name = "vdd1p8";
+				regulator-name = "vdd1p8";
 				regulator-min-microvolt = <1033310>;
 				regulator-max-microvolt = <2004000>;
 				lltc,fb-voltage-divider = <301000 200000>;
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index d5c3aa8..6e29d8b 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -223,7 +223,7 @@
 	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
 	vmcc-supply = <&reg_sd3_vmmc>;
 	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-	bus-witdh=<4>;
+	bus-witdh = <4>;
 	no-1-8-v;
 	status = "okay";
 };
@@ -234,7 +234,7 @@
 	pinctrl-1 = <&pinctrl_usdhc4_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc4_200mhz>;
 	vmcc-supply = <&reg_sd4_vmmc>;
-	bus-witdh=<8>;
+	bus-witdh = <8>;
 	no-1-8-v;
 	non-removable;
 	status = "okay";
-- 
1.9.1
