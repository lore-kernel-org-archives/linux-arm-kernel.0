From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 18 Jun 2018 16:58:32 +0200
Subject: [PATCH v4 08/19] ARM: dts: sun5i: Use dedicated SRAM controller
 compatible
In-Reply-To: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180618145843.14631-9-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly-introduced SRAM controller compatible for the A13 and
other sun5i platforms instead of its A10 fashion.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 07f2248ed5f8..72433f38b4e4 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -115,7 +115,7 @@
 		ranges;
 
 		sram-controller at 1c00000 {
-			compatible = "allwinner,sun4i-a10-sram-controller";
+			compatible = "allwinner,sun5i-a13-sram-controller";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.17.0
