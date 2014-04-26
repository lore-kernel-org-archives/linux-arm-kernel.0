From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 26 Apr 2014 08:52:09 +0400
Subject: [PATCH 4/8] ARM: dts: imx: Remove excess entries for PMIC
In-Reply-To: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
Message-ID: <1398487933-5683-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes excess "#address-cells" and "#size-cells" entries
for PMIC, since these entries is not used.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-pdk.dts                 | 2 --
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 2 --
 arch/arm/boot/dts/imx51-babbage.dts             | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 764cf79..4c31771 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -42,8 +42,6 @@
 	status = "okay";
 
 	pmic: mc13783 at 0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "fsl,mc13783";
 		reg = <0>;
 		spi-cs-high;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index b81796c..31e9f70 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -80,8 +80,6 @@
 	status = "okay";
 
 	pmic: mc13783 at 0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "fsl,mc13783";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index e9ce0c0..89470bf 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -191,8 +191,6 @@
 	status = "okay";
 
 	pmic: mc13892 at 0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
 		compatible = "fsl,mc13892";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
-- 
1.8.3.2
