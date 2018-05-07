From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon,  7 May 2018 14:44:50 +0200
Subject: [PATCH v3 04/14] ARM: dts: sun7i-a20: Use dedicated SRAM controller
 compatible
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180507124500.20434-5-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly-introduced SRAM controller compatible for the A20 instead
of its A10 fashion.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e529e4ff2174..b179e05408e4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -240,7 +240,7 @@
 		ranges;
 
 		sram-controller at 1c00000 {
-			compatible = "allwinner,sun4i-a10-sram-controller";
+			compatible = "allwinner,sun7i-a20-sram-controller";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.16.3
