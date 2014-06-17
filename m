From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 17 Jun 2014 01:07:35 -0300
Subject: [PATCH] ARM: dts: imx6sx: Use "vddarm" as the regulator name
Message-ID: <1402978055-19625-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The other i.mx6 variants use "vddarm" as the name of the internal regulator
that powers the core. Use the same convention here for consistency.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index ac3866c..78ccf61 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -581,7 +581,7 @@
 
 				reg_arm: regulator-vddcore at 140 {
 					compatible = "fsl,anatop-regulator";
-					regulator-name = "cpu";
+					regulator-name = "vddarm";
 					regulator-min-microvolt = <725000>;
 					regulator-max-microvolt = <1450000>;
 					regulator-always-on;
-- 
1.8.3.2
