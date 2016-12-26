From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Mon, 26 Dec 2016 18:53:49 +0100
Subject: [PATCH] ARM: dts: sunxi: Enable spi1 and spi2 for Olimex A20 SOM EVB
Message-ID: <20161226175349.17712-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the spi1 and spi2 node since the pins are exposed on the UEXT
connectors.

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 669a1c338c76..fa8c6f60552b 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -300,12 +300,14 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins_a>,
 		    <&spi1_cs0_pins_a>;
+	status = "okay";
 };
 
 &spi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi2_pins_a>,
 		    <&spi2_cs0_pins_a>;
+	status = "okay";
 };
 
 &uart0 {
-- 
2.11.0
