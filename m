From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 15 Apr 2016 19:35:03 +0900
Subject: [PATCH] ARM: dts: uniphier: add NAND pinmux node
In-Reply-To: <1460716503-31128-1-git-send-email-yamada.masahiro@socionext.com>
References: <1460716503-31128-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1460716503-31128-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 2459279..52d67bf 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -68,6 +68,11 @@
 		function = "i2c4";
 	};
 
+	pinctrl_nand: nand_grp {
+		groups = "nand";
+		function = "nand";
+	};
+
 	pinctrl_uart0: uart0_grp {
 		groups = "uart0";
 		function = "uart0";
-- 
1.9.1
