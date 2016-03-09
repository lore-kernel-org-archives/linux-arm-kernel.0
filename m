From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  9 Mar 2016 14:25:43 +0900
Subject: [PATCH] ARM: dts: uniphier: add pinmux node for I2C ch4
Message-ID: <1457501143-24535-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be needed for UniPhier PH1-LD11 and PH1-LD20 SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index f67445f..2459279 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -63,6 +63,11 @@
 		function = "i2c3";
 	};
 
+	pinctrl_i2c4: i2c4_grp {
+		groups = "i2c4";
+		function = "i2c4";
+	};
+
 	pinctrl_uart0: uart0_grp {
 		groups = "uart0";
 		function = "uart0";
-- 
1.9.1
