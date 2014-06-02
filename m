From: tharvey@gateworks.com (Tim Harvey)
Date: Mon,  2 Jun 2014 11:44:01 -0700
Subject: [PATCH] ARM: dts: imx6: ventana: correct gw52xx sgtl5000 clock source
Message-ID: <1401734641-27308-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the invalid clock for the sgtl5000 audio codec on the GW52xx Ventana
baseboard.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index eb8e293..e9fbef0 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -281,7 +281,7 @@
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
-		clocks = <&clks 169>;
+		clocks = <&clks 201>;
 		VDDA-supply = <&reg_1p8v>;
 		VDDIO-supply = <&reg_3p3v>;
 	};
-- 
1.8.3.2
