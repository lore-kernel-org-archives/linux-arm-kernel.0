From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 18 Oct 2018 13:26:13 +0200
Subject: [PATCH v1 1/3] ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c node
In-Reply-To: <20181018112615.29362-1-o.rempel@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
Message-ID: <20181018112615.29362-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 000e6136a9d6..3e6ffaf5f104 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -709,7 +709,7 @@
 			i2c1: i2c at 21a0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fs,imx6sll-i2c", "fsl,imx21-i2c";
+				compatible = "fsl,imx6sll-i2c", "fsl,imx21-i2c";
 				reg = <0x021a0000 0x4000>;
 				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_I2C1>;
-- 
2.19.0
