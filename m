From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 18 Jun 2016 20:09:11 +0300
Subject: [PATCH 1/2] ARM: dts: imx27-phytec-phycore-som: Add simple-card
 support for PMIC
Message-ID: <1466269752-8548-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds simple-card support for the MC13783 PMIC.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index b4e955e..9908b42 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -80,6 +80,7 @@
 	status = "okay";
 
 	pmic: mc13783 at 0 {
+		#sound-dai-cells = <0>;
 		compatible = "fsl,mc13783";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
-- 
2.4.9
